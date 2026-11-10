"""oc_sessions - read opencode session data from every local store.

opencode keeps session data in more than one place:

  V2 (current): opencode.db, tables session_v2 + session_message.
                Tool calls live inside assistant message JSON (data.content[]).
  V1 (legacy):  opencode-stable.db (and old rows in opencode.db), tables
                session + message + part. V1 stopped receiving new sessions
                when opencode moved to V2 (late Oct / early Nov 2026).

A search that reads only one store silently misses sessions. Use this module
instead of hand-written SQL so every script sees both stores.

Store discovery:
  - $OPENCODE_DB, when it is an absolute path to an existing file, is the
    ONLY store used (opencode exports a relative OPENCODE_DB into its shells;
    that value is ignored).
  - Otherwise every *.db in $OPENCODE_DATA_DIR (default
    ~/.local/share/opencode) and its storage/ subdir is probed for the tables.

Rows from V2 win over V1 rows with the same session id.
"""

import glob
import json
import os
import sqlite3

DATA_DIR = os.environ.get(
    "OPENCODE_DATA_DIR", os.path.expanduser("~/.local/share/opencode"))


def db_paths(override=None):
    """Return the list of DB files to read."""
    if override:
        return [override]
    env = os.environ.get("OPENCODE_DB", "")
    if env.startswith("/") and os.path.isfile(env):
        return [env]
    paths = sorted(glob.glob(os.path.join(DATA_DIR, "*.db"))
                   + glob.glob(os.path.join(DATA_DIR, "storage", "*.db")))
    return [p for p in paths if os.path.isfile(p)]


def _tables(con):
    return {r[0] for r in con.execute(
        "SELECT name FROM sqlite_master WHERE type='table'")}


class Store:
    """One DB file with the schema flavours it contains."""

    def __init__(self, path, writable=False):
        self.path = path
        if writable:
            self.con = sqlite3.connect(path, timeout=20)
            self.con.execute("PRAGMA busy_timeout=20000")
        else:
            self.con = sqlite3.connect(f"file:{path}?mode=ro", uri=True)
        t = _tables(self.con)
        self.v2 = {"session_v2", "session_message"} <= t
        self.v1 = {"session", "message", "part"} <= t
        self.todo = "todo" in t

    def close(self):
        self.con.close()


def open_stores(override=None, writable=False):
    stores = []
    for p in db_paths(override):
        try:
            s = Store(p, writable)
        except sqlite3.Error:
            continue
        if s.v1 or s.v2:
            stores.append(s)
        else:
            s.close()
    return stores


def _between(col, since, until):
    sql, args = "", []
    if since is not None:
        sql += f" AND {col}>=?"
        args.append(since)
    if until is not None:
        sql += f" AND {col}<?"
        args.append(until)
    return sql, args


def sessions(stores, since=None, until=None, top_level=True):
    """Sessions updated in [since, until) (epoch ms), newest first.

    Keys: id, title, directory, created, updated, parent_id, cost,
    tokens_in, tokens_out, model, store, schema.
    """
    out = {}
    parent = " AND parent_id IS NULL" if top_level else ""
    for s in stores:
        if s.v2:
            w, a = _between("time_updated", since, until)
            for r in s.con.execute(
                    "SELECT id,title,directory,time_created,time_updated,parent_id,"
                    "cost,tokens_input,tokens_output,json_extract(model,'$.id') "
                    f"FROM session_v2 WHERE 1=1{parent}{w}", a):
                out[r[0]] = _sess(r, s.path, "v2")
    for s in stores:
        if s.v1:
            w, a = _between("time_updated", since, until)
            for r in s.con.execute(
                    "SELECT id,title,directory,time_created,time_updated,parent_id,"
                    "cost,tokens_input,tokens_output,json_extract(model,'$.id') "
                    f"FROM session WHERE 1=1{parent}{w}", a):
                out.setdefault(r[0], _sess(r, s.path, "v1"))
    return sorted(out.values(), key=lambda x: x["updated"], reverse=True)


def _sess(r, path, schema):
    return {"id": r[0], "title": r[1], "directory": r[2], "created": r[3],
            "updated": r[4], "parent_id": r[5], "cost": r[6] or 0,
            "tokens_in": r[7] or 0, "tokens_out": r[8] or 0, "model": r[9],
            "store": path, "schema": schema}


def open_todos(stores, since=None):
    """Open (pending/in_progress) todos whose session was updated >= since.

    Keys: status, content, position, session_id, session_title,
    session_updated, store.
    """
    out, seen = [], set()
    for s in stores:
        if not s.todo:
            continue
        for tbl in (("session_v2",) if s.v2 else ()) + (("session",) if s.v1 else ()):
            w, a = _between("s.time_updated", since, None)
            for r in s.con.execute(
                    "SELECT t.status,t.content,t.position,s.id,s.title,s.time_updated "
                    f"FROM todo t JOIN {tbl} s ON s.id=t.session_id "
                    f"WHERE t.status IN ('pending','in_progress'){w}", a):
                key = (r[3], r[2])
                if key in seen:
                    continue
                seen.add(key)
                out.append({"status": r[0], "content": r[1], "position": r[2],
                            "session_id": r[3], "session_title": r[4],
                            "session_updated": r[5], "store": s.path})
    out.sort(key=lambda t: (t["status"] != "in_progress",
                            -t["session_updated"], t["position"]))
    return out


def _content_text(content):
    if isinstance(content, str):
        return content
    if isinstance(content, list):
        return "\n".join(c.get("text", "") for c in content
                         if isinstance(c, dict) and c.get("text"))
    return ""


def _err_text(err):
    if isinstance(err, dict):
        return err.get("message") or json.dumps(err)
    return err


def tool_calls(stores, since=None):
    """Yield every tool call as a dict.

    Keys: tool, status, error, input (JSON string), output, session_id, schema.
    V2 tool names are kept as-is (e.g. `shell`, where V1 used `bash`).
    """
    for s in stores:
        if s.v2:
            w, a = _between("time_created", since, None)
            for sid, data in s.con.execute(
                    "SELECT session_id,data FROM session_message "
                    f"WHERE type='assistant' AND data LIKE '%\"type\":\"tool\"%'{w}", a):
                try:
                    d = json.loads(data)
                except ValueError:
                    continue
                for c in d.get("content") or []:
                    if not isinstance(c, dict) or c.get("type") != "tool":
                        continue
                    st = c.get("state") or {}
                    yield {"tool": c.get("name"), "status": st.get("status"),
                           "error": _err_text(st.get("error")),
                           "input": json.dumps(st.get("input") or {}),
                           "output": _content_text(st.get("content")),
                           "session_id": sid, "schema": "v2"}
        if s.v1:
            w, a = _between("time_created", since, None)
            for sid, tool, status, err, inp, outp in s.con.execute(
                    "SELECT session_id,json_extract(data,'$.tool'),"
                    "json_extract(data,'$.state.status'),json_extract(data,'$.state.error'),"
                    "json_extract(data,'$.state.input'),json_extract(data,'$.state.output') "
                    f"FROM part WHERE json_extract(data,'$.type')='tool'{w}", a):
                yield {"tool": tool, "status": status, "error": err,
                       "input": inp or "", "output": outp or "",
                       "session_id": sid, "schema": "v1"}


def user_texts(stores, since=None):
    """Yield (text, session_id) for every user-authored text message."""
    for s in stores:
        if s.v2:
            w, a = _between("time_created", since, None)
            for sid, t in s.con.execute(
                    "SELECT session_id,json_extract(data,'$.text') FROM session_message "
                    f"WHERE type='user'{w}", a):
                if t:
                    yield t, sid
        if s.v1:
            w, a = _between("p.time_created", since, None)
            for t, sid in s.con.execute(
                    "SELECT json_extract(p.data,'$.text'),p.session_id "
                    "FROM part p JOIN message m ON p.message_id=m.id "
                    "WHERE json_extract(p.data,'$.type')='text' "
                    f"AND json_extract(m.data,'$.role')='user'{w}", a):
                if t:
                    yield t, sid


def search(stores, needle, limit=50):
    """Sessions whose title or message content contains `needle` (case-insensitive)."""
    hits = {}
    like = f"%{needle}%"
    for s in stores:
        if s.v2:
            for sid, n in s.con.execute(
                    "SELECT session_id,count(*) FROM session_message "
                    "WHERE data LIKE ? GROUP BY session_id", (like,)):
                hits[sid] = hits.get(sid, 0) + n
            for (sid,) in s.con.execute(
                    "SELECT id FROM session_v2 WHERE title LIKE ?", (like,)):
                hits.setdefault(sid, 0)
        if s.v1:
            for sid, n in s.con.execute(
                    "SELECT session_id,count(*) FROM part "
                    "WHERE data LIKE ? GROUP BY session_id", (like,)):
                hits[sid] = hits.get(sid, 0) + n
            for (sid,) in s.con.execute(
                    "SELECT id FROM session WHERE title LIKE ?", (like,)):
                hits.setdefault(sid, 0)
    meta = {x["id"]: x for x in sessions(stores, top_level=False)}
    rows = []
    for sid, n in hits.items():
        m = meta.get(sid, {"id": sid, "title": None, "directory": None,
                           "updated": 0, "schema": "?"})
        rows.append(dict(m, matches=n))
    rows.sort(key=lambda x: x["updated"], reverse=True)
    return rows[:limit]
