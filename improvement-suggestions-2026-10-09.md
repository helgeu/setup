# Improvement suggestions — 2026-10-09 (window: since 2026-07-11)

Produced by the `error-reduction` workflow: sensor `oc-error-scan --json
--since 2026-07-11 -n 5`, AI pass per the `error-reduction` skill. Raw scan:
`~/.claude/error-reduction/scan-2026-10-09.json`.

This pass also added the tooling itself: the `error-reduction` skill, the
headless `error-reduction` agent, the `oc-error-reduce` script, and the
missing `oc-error-scan` wiring in `nix/bin/default.nix`. They go live in your
clients after your `switch.sh` + restart. It also rewrote the grep rule in
`ai/shared/global-rules.md` (classes 1–2): shorter, positive framing, one
canonical bash form, and an explicit `-E` clause.

## Coverage

- Sensors run: `oc-error-scan` (opencode SQLite session DB,
  `~/.local/share/opencode/opencode-stable.db`), window 2026-07-11..2026-10-09.
- NOT covered: Claude Code sessions (`~/.claude/projects/**/*.jsonl`, 17
  session files) — no sensor exists. Proposal P2 adds `claude-error-scan`.
- Scanned: 692 tool errors, 3191 user messages.
- Frustration (symptom metric, not a fix class): 710 of 3191 user messages
  (22%) matched a frustration signal — hard profanity 214, frustration
  phrases 390, weak corrections 254. It should fall as the classes below are
  removed.

## Error classes

Counts overlap (one event can match several classes). Pattern counts come
from the sensor's known-pattern detectors; string counts from normalized
error strings.

| # | Class | Count | Source | Type | Note |
| --- | --- | --- | --- | --- | --- |
| 1 | grep_include | 200 | opencode | deterministic | `grep`/`rtk grep` called with `--include`; the rule exists, the model violates it (count is attempts — see note below the table) |
| 2 | grep -E collision | 148 | opencode | deterministic | `grep -E` / `-rniE` habits hit rg's `-E` = encoding (`unknown encoding` in output); rg regex is always extended |
| 3 | user-driven bucket | 194 | opencode | user-driven | aborts 82, permission-rule denials 64, dismissed question 24, task cancelled 17, permission rejected 7 |
| 4 | path_guessing | 159 | opencode | non-deterministic | read/glob of paths that do not exist ("File not found" 158; related: FileSystem.access 9, offset out of range 6) |
| 5 | ado_auth | 114 | opencode | deterministic | raw `az` without login / TF400813; helper scripts preflight auth, raw bash does not |
| 6 | url_404 | 118 | opencode | non-deterministic | webfetch non-2xx (127); mix of guessed URLs and dead external links |
| 7 | ripgrep failures | 78 | opencode | non-deterministic | "JSON record exceeded N bytes" 43 (huge/minified files), "execution failed" 35 (unreadable paths) |
| 8 | jq_parse | 72 | opencode | deterministic | `jq` on non-JSON (az error text, prose, control chars); the "never `az … 2>&1 | jq`" rule exists |
| 9 | question SchemaError | 53 | opencode | non-deterministic | question tool called with wrong args (46 missing key, 7 expected array) |
| 10 | edit freshness / no-op | 45 | opencode | deterministic | "Could not find oldString" 31, identical old/new 8, read offset out of range 6 |

Note on class 1: the sensor counts attempts (any bash command containing `--include=`). In the 90-day window ~197 such commands ran; 150 (76%) carried `2>/dev/null` and only 21 showed `rg: unrecognized flag --include` in the output. The failures are silent empty results, not visible errors — the real cost is wrong "no matches" conclusions and wasted calls. Class 2 is the same root cause via `-E`.

By tool (context): read 198, webfetch 135, bash 82, question 78, grep 68,
edit 51, task 31, glob 29, write 19, todowrite 1.

## Decomposition trees (non-deterministic classes)

**path_guessing (159)**

```
read/glob of a path that does not exist
├── agent recalled the path from memory, never verified it
│   → deterministic-fix: hook fails fast on a missing read/edit target and
│     returns glob candidates (P1)
├── agent worked in the wrong directory/repo
│   → judgment-bound: instruction — state the cwd assumption before reading
│     outside it (P3)
└── stale file state (offset beyond EOF, content changed since read)
    → deterministic-fix: hook re-checks offset/size and edit freshness (P1)
```

**url_404 (118)**

```
webfetch returns non-2xx
├── agent fabricated or guessed the URL
│   → deterministic-fix: hook allows only URLs seen in user messages or
│     local files (provenance check) (P1)
├── URL was real but is dead/moved (external)
│   → judgment-bound: no fix; accept and log
└── blocked, rate-limited, or auth-walled
    → judgment-bound: retry/manual-fetch decision
```

**question SchemaError (53)**

```
question tool called with invalid arguments
├── no instruction documents the exact arg shape
│   → deterministic-fix: add a question-tool usage rule to global-rules (P3)
└── deciding when to ask at all
    → judgment-bound: model judgment; existing skill guidance covers it
```

**ripgrep failures (78)**

```
grep tool fails
├── huge or minified file (record exceeds max bytes)
│   → deterministic-fix: hook size guard + instruction to glob/scope first
│     (P1, P3)
├── unreadable path (/nix/store, permission-denied)
│   → deterministic-fix: instruction — never grep /nix/store or unreadable
│     paths (P3)
└── wrong pattern for the corpus
    → judgment-bound: model judgment
```

## Proposals

### P1 — Enforcement guardrails (opencode plugin + Claude Code hook)

Covers classes 1 (grep_include), 2 (grep -E collision), 8 (jq_parse), 10 (edit
freshness/no-op), and the deterministic leaves of 4 and 7.

- Destination: opencode plugin
  `~/git/github/setup/nix/ai/opencode/plugins/guardrails.ts` + wiring in
  `ai/opencode/default.nix`; Claude Code `PreToolUse` Bash hook in
  `ai/claude/settings.json` + `ai/claude/default.nix`.
- Reuse: none. New: `guardrails` plugin + `guardrails-hook.sh`. The rtk hook
  pattern in `settings.json` is the model.
- What it does (deterministic rewrites/blocks, `tool.execute.before` /
  PreToolUse):
  - `grep`/`rtk grep` with `--include=X` → rewrite to `-g 'X'` (rtk already
    rewrites grep→rg; this completes it).
  - `grep`/`rtk grep` with `-E` (alone or inside combined flags like
    `-rniE`) → drop the `E` — rg's `-E` is encoding; rg regex is always
    extended.
  - `az … 2>&1 | jq …` → drop `2>&1` (stderr breaks jq parsing).
  - `read`/`edit` target missing → fail fast and return `glob` candidates
    instead of a bare "File not found".
  - `edit` on a file not read this session, or offset beyond EOF → fail fast
    with "read the file first".
  - `edit` with identical oldString/newString → block (no-op guard).
  - bash command starting with `az ` → run the connectionData auth preflight
    first (the same check the ADO helper scripts bake in); on failure print
    the `ado-login` hint.
- Ship steps: edit the four source files → `git add` → `./scripts/check.sh` +
  `./scripts/eval.sh` → commit (you approve) → `sudo ./scripts/switch.sh`
  (you run) → restart both clients → verify.
- Rationale: classes 1, 2, 8, 10 are known-rule compliance failures — the
  instructions exist and the model keeps violating them. Enforcement removes
  them deterministically, and the path/offset leaves become fast,
  self-correcting errors instead of dead ends.

### P2 — `claude-error-scan` sensor (closes the coverage gap)

- Destination: helper script `~/git/github/setup/nix/bin/claude-error-scan` +
  entry in `nix/bin/default.nix`.
- Reuse: new script, modeled on `oc-error-scan`; emits the sensor contract
  from the `error-reduction` skill (normalized tool errors, top error
  strings, frustration tiers, known patterns) from Claude Code JSONL sessions
  under `~/.claude/projects/`.
- Ship steps: edit `nix/bin/claude-error-scan`, `nix/bin/default.nix` →
  `git add` → `./scripts/check.sh` → commit (you approve) →
  `sudo ./scripts/switch.sh` → verify with
  `claude-error-scan --json | jq .tool_errors.total`.
- Rationale: 17 Claude Code sessions are currently invisible. Without a
  sensor the classes above are opencode-only and the frustration signal
  misses a whole client.

### P3 — global-rules additions (instruction changes)

- Destination: `~/git/github/setup/nix/ai/shared/global-rules.md` (feeds both
  `~/.claude/CLAUDE.md` and `~/.config/opencode/AGENTS.md`).
- Reuse: edit the existing file. The grep/ADO/path rules exist — these are
  additions, not rewrites:
  1. question tool: pass exactly
     `{ "questions": [ { "question", "header", "options" } ] }`;
     `options[].label` + `description` are required.
  2. Never grep `/nix/store` or unreadable paths; for huge/minified files,
     glob first and grep a target file, not a tree.
  3. Before any raw `az` command, run `ado-login` (or use a helper script —
     they preflight auth).
  4. State the working-directory assumption before reading files outside the
     cwd.
- Ship steps: edit `ai/shared/global-rules.md` → `git add` → `check.sh` +
  `eval.sh` → commit (you approve) → `sudo ./scripts/switch.sh` → restart
  both clients → verify.
- Rationale: covers the deterministic leaves the hooks cannot (question arg
  shape, grep scope, auth preflight habit, cwd assumptions) and feeds both
  clients from one source.

### P4 — Permission-config review (user-driven bucket, optional)

- Destination: opencode config in `ai/opencode/default.nix` (the
  `opencode.jsonc` permission block).
- Reuse: edit the existing config.
- The 64 "user has specified a rule which prevents you from using this tool"
  events are the permission system denying tools the agent tried. If the
  denials are legitimate guardrails, change nothing; if they are friction
  (external_directory prompts that could be pre-approved), extend the
  allowlist deliberately.
- Ship steps: same nix pipeline; restart opencode.
- Rationale: user-driven by definition — tune deliberately, never widen
  silently.

### No new skills beyond `error-reduction`

The judgment-bound leaves (wrong-directory exploration, dead external URLs,
when to ask) are model judgment. P3 covers them with instruction additions,
and the `error-reduction` skill itself is the loop that verifies the fixes. A
skill cannot enforce a rule — P1 does that.

## Smoke test (tooling verification)

- Verified by direct probes on 2026-10-09: the script runs the sensor,
  resolves the session DB (including the relative `OPENCODE_DB` quirk), and
  invokes `opencode run --agent error-reduction`; the agent loads, reads the
  scan, and the permission scope behaves as designed (write to the
  `improvement-suggestions-*.md` glob allowed; other external paths denied for
  file tools).
- Permission-model finding: `external_directory` gates the file tools
  (read/write/edit) but NOT bash. The first agent draft (`bash: "*": allow`)
  could write anywhere via bash. The shipped agent denies all bash except
  `jq`. Note: the `pr-review` agent has the same bash hole — consider
  tightening it in a follow-up (it needs az/git/dotnet, so it needs a pattern
  allowlist instead of deny-all).
- This plan doc was produced by the primary agent (mistral-large-4) executing
  the skill workflow directly — no local model involved. After your
  `switch.sh`, `oc-error-reduce` runs the same pass with the model you pass
  (`--model` / `ERROR_REDUCE_MODEL` / opencode default).

## Verification plan

- After P1 + P3 ship: re-run `oc-error-scan --since <ship date>` (or
  `oc-error-reduce --since <ship date>` once rebuilt). Targets: grep_include
  200 → ~0, grep -E collision 148 → ~0, jq_parse 72 → ~0, path_guessing 159
  → large drop (residual = judgment-bound wrong-directory cases), edit
  freshness 45 → ~0, ado_auth 114 → ~0 (hook preflight).
- After P2 ships: run `claude-error-scan`, merge classes, tag source
  clients; new classes get the same classify → decompose → propose loop.
- Symptom metric: frustration 22% of user messages should fall as the top
  classes drop. Re-check after 2–4 weeks.
- Loop: `oc-error-reduce` (one go) after your `switch.sh`; each run writes a
  dated plan doc so progress is comparable run over run.