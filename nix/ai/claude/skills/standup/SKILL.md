---
name: standup
description: Summarize work activity for a standup or status update — answers "what did I do this week / yesterday / today", "what am I working on / planning next", and "do I have any blockers". Use when the user asks for a recap of what they've done, what's next, or blockers. Pulls from the local opencode session DB (via the `standup` script) and cross-references Azure DevOps (PRs, work items, pipeline/build status).
---

# Standup / activity recap

A standup is a **meeting frame**, not a date window. `standup` / `standup today`
answers the standup for *today's* meeting:

1. **What did I do?** — yesterday / since the last standup (the `did` list)
2. **What am I planning to do today?** — current open todos (`plan`)
3. **Any blockers?** — open todos that look blocked (`blockers`)

## Step 1 — pull local activity (always)

Run the `standup` helper (see `~/.claude/scripts-reference.md`). It reads the
local opencode session DB and is the source of truth.

```bash
standup                  # standup frame: did=last active day, plan=today, blockers
standup today            # same as above
standup --json           # machine-readable; prefer this when composing a summary
# raw recaps (for "what did I literally do over X"):
standup yesterday        # just yesterday's sessions
standup week             # last 7 days
standup --days N
```

JSON shape: `{ today, did_window, did[], plan[], blockers[] }` where `today` is
the authoritative current weekday+date (e.g. `Thursday 2026-07-30`),
`did_window` is the concrete day/range the `did` list covers, each `did` entry is
`{updated, directory, title}` and each `plan`/`blockers` entry is
`{status, session, content}`.

**Never hand-write the date or weekday.** Use the `today` / `did_window` fields
verbatim in your header. Guessing the weekday is how you end up labelling a
Wednesday "tirsdag".

Map the data to the standup answers:

- **Did** = the `did` list (yesterday / last active day). Group by repo (the last
  path segment of `directory`). Collapse many sessions on the same PR/work item
  into one line. Titles are already descriptive — keep it tight.
- **Plan** = `plan` (open todos): `in_progress` first, then `pending`. This is
  scoped to recently-active sessions, so it reflects current work, not ancient
  scaffolding.
- **Blockers** = `blockers[]` (todos mentioning BLOCK/WAITING/AVVENT). Read the
  full text for the real cause.

Do **not** just dump the raw lists — synthesize. Give a tight, grouped,
high-level recap with specifics (PR/work-item numbers) the user can read aloud.

But do **not** present yet — the session-DB status is a hint, not the truth. A
todo can still say `pending`/`in_progress` after its PR merged or its work item
closed. Go through Step 2 first and let live state re-classify the lists.

## Step 2 — verify against live state, then reclassify (MANDATORY)

This runs **every** standup, before you present anything. The goal: nothing lands
in **Gjort/Neste/Blokkere** on the strength of a stale local todo. Reconcile the
draft lists against Azure DevOps *all around* first.

For every draft item that carries a PR or work-item number (or is clearly tied to
one), confirm its live state and move it if reality disagrees:

- **PR merged / completed, or work item Closed/Resolved** → move the item from
  **Neste** into **Gjort**, and flip the corresponding local todo to `completed`
  (so it doesn't resurface next time).
- **Blocker whose blocking PR/WI is now resolved** → drop it from **Blokkere**
  (into Gjort if it was the user's own work, otherwise just remove).
- **Item you were about to call "done" whose PR is still active, in draft, or has
  a red required build** → keep it in **Neste**/in-progress and say why (e.g.
  "venter på review", "build rød — Trivy CVE").
- **Anything with no PR/WI to check** → leave as the session DB reported it.

Only after this pass do the lists reflect what's actually done vs outstanding.

### Tools for the check

Use the existing helper scripts first (`~/.claude/scripts-reference.md`):
`azprs <org>` for my open/merged PRs, `ado-my-items` for assigned work-item
state, `find-prs` inside a repo. Drop to raw `az` for pipeline/build detail.

### `az boards` / `az devops invoke` gotchas (learned the hard way)

- **Never put `[System.TeamProject] = @project` in a WIQL `WHERE`** — with
  `az boards query --project ...` it silently returns an empty result set.
  Omit it; the `--project` flag already scopes the query.
- **Don't trust `[System.CreatedBy] = @me`** to find items you created — the
  az-login identity often differs from the ADO author. Filter by title
  `CONTAINS` / area / iteration / date instead.
- **API version is `7.1-preview`**, not `7.1-preview.3` — `az devops invoke`
  errors with `could not convert string to float: '7.1.3'` otherwise.

### Recipes

```bash
ORG="https://imdidev.visualstudio.com"; PROJ="Bosettingsprosjekt"

# Work items I created recently (filter by title/date, NOT @me/@project):
az boards query --org "$ORG" --project "$PROJ" \
  --wiql "SELECT [System.Id],[System.WorkItemType],[System.State],[System.Title] \
          FROM WorkItems WHERE [System.Title] CONTAINS 'SPIKE' \
          ORDER BY [System.ChangedDate] DESC"

# Comments on a work item:
az devops invoke --org "$ORG" --area wit --resource comments \
  --route-parameters project=$PROJ workItemId=<id> --api-version 7.1-preview

# Latest main builds for a pipeline (FE=510, BE=517 in Bosettingsprosjekt):
az pipelines runs list --org "$ORG" --project "$PROJ" \
  --pipeline-ids <id> --branch refs/heads/main --top 5 \
  --query "[].{id:id,num:buildNumber,result:result,finish:finishTime}" -o tsv

# Why a build failed — stages/jobs/tasks + issue messages:
az devops invoke --org "$ORG" --area build --resource timeline \
  --route-parameters project=$PROJ buildId=<id> --api-version 7.1-preview
#   -> records[] with type Stage/Phase/Job/Task; filter result=='failed';
#      Task records carry issues[].message (e.g. Trivy CVE, missing path).

# Full log of one failing task (logId from the timeline record's .log.id):
az devops invoke --org "$ORG" --area build --resource logs \
  --route-parameters project=$PROJ buildId=<id> logId=<N> --api-version 7.1-preview
#   -> .value is an array of lines, each prefixed by a ~31-char ISO timestamp.
```

A red overall build often deployed fine: check the **stage** results. A failing
smoke-test/e2e stage can still mean "app deployed to test, tests flaky/broken",
whereas a failing build/push stage (e.g. Trivy CVE) means nothing deployed.

## Step 3 — present it

Output a **Teams-pasteable, flat plain-text** block: it must survive a raw
copy-paste into the Teams compose box. That means:

- **Plain-word headers** on their own line (`Gjort`, `Neste`, `Blokkere`) — no
  markdown `**bold**` and no `#` headings (Teams shows literal asterisks / breaks
  on paste).
- **Single-level `•` bullets only** — no nesting, no `-`/`*` (Teams auto-converts
  `-` into its own re-nested list). Collapse sub-items into one line each.
- One blank line between the three sections; keep each bullet to a single line
  with PR/WI numbers inline.
- Put the whole thing in a fenced code block so the user copies it verbatim.
- Norwegian or English to match the user; order Neste as in_progress first, then
  pending.

```
Gjort (<did_window>)
• …grouped, with PR/WI numbers, one line each…

Neste
• …in_progress first, then pending…

Blokkere
• …or "ingen"…
```

After the block, remind once: paste with **Ctrl/⌘+Shift+V** (paste without
formatting) for the cleanest result.

## Step 4 — keep `~/Documents/IMDI/todo-2026.md` in order (STANDING ORDER)

This is a **standing order**, not an on-request favour: every time you run a
standup, reconcile this file so it stays an accurate, tidy, high-level backlog.
Do it as part of the standup and then show the user a short summary of what you
changed (or "already in order — no changes").

**Reconcile from the Step 2 verified state, not the raw session DB.** By the time
you reach here you've already confirmed live PR/work-item/build status and
reclassified Gjort/Neste/Blokkere — the todo file must reflect *that* verified
picture. Anything Step 2 moved into Gjort (PR merged, WI closed, blocker
resolved) gets checked off / dropped here too; anything it kept in Neste stays
open. Never mark an item done in this file on the strength of a local todo status
you haven't verified against ADO.

What the file is: the user's **durable, high-level** work backlog — real work
items, follow-ups, and initiatives, written so they can be read aloud, each with
an ADO link where one exists. What it is **not**: a mirror of every open todo in
the session DB. Keep judgment in the loop.

Reconciliation rules (apply only to the active section, e.g. "Å gjøre videre";
never touch dated historical sections like "Juni"):

- **Remove/close done work.** If a plan item is finished or was cancelled (a todo
  flipped to `completed`/`cancelled`, or Step 2 confirmed a PR merged / work item
  closed), check it off (`[x]`) or drop it — don't leave stale open items.
- **Add newly-surfaced durable items** from `plan`/`blockers` that belong here:
  standing work, follow-ups, product decisions, spikes. Write them high-level and
  self-explanatory with ADO links — **never** internal codes (no "P3", "B404-7",
  session names, file:line lists).
- **Do NOT add transient noise.** Exclude PR-review chores, individual
  commit/push/gitleaks steps, SonarCloud re-checks, one-off experiments, and
  abandoned discussions. When in doubt whether something is durable, ask.
- **Don't duplicate.** If the item is already there (possibly worded
  differently), leave the existing wording; don't add a second copy.
- **Preserve format.** Norwegian, `- [ ]`/`- [x]` checkboxes, nested sub-items,
  ADO links in the existing `[title](url)` style. Match surrounding style.

Because this needs judgment (durable vs transient, dedup, wording), it lives in
this skill, not in the `standup` script. Reconcile, then report the delta.
