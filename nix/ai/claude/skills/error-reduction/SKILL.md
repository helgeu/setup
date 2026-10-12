---
name: error-reduction
description: Turns recurring errors and frustration signals from AI coding sessions into classified, decomposed improvement suggestions (reused or new scripts, instruction changes, skill changes). Use when the user wants to analyze session errors, reduce recurring errors, or improve the AI setup from session history. Driven headlessly by the `oc-error-reduce` script; produces a plan doc and never implements anything.
---

# Error reduction — session errors → improvement suggestions

You turn error signals from AI coding session history into a **plan doc of
improvement suggestions**. You do **not** implement anything: no script edits,
no instruction edits, no commits. Implementation is a separate, human-approved
step that follows the ship steps listed per proposal in the plan doc.

## Inputs you are given

When invoked by the `oc-error-reduce` script you receive, in the prompt:

- An **error scan JSON file** — the pre-generated output of a sensor (default:
  `oc-error-scan`, reading the opencode session DB). Trust it. **Read it; do
  not re-run the sensor and do not touch session databases.**
- The **sensor name** and the **time window**.
- The **output path where you must create** the plan doc, typically
  `~/git/github/setup/improvement-suggestions-<date>.md`. This file is an
  *output you create* — it is not an input. Do not search the filesystem for
  inputs beyond the scan file.

If the scan file is missing or is not valid JSON, stop and report — do not
guess.

## Sensor contract (normalized error signals)

Every sensor emits the same JSON shape so error classes aggregate across
clients:

```json
{
  "since": "2026-07-11",
  "tool_errors": { "total": 0, "by_tool": { "read": 0 } },
  "top_error_strings": { "<normalized error>": 0 },
  "frustration": {
    "user_messages": 0, "hard": 0, "frust": 0, "weak": 0,
    "any": 0, "any_pct": 0,
    "examples": [{ "text": "...", "session": "ses_..." }]
  },
  "known_patterns": {
    "<pattern>": { "count": 0, "examples": [{ "text": "...", "session": "ses_..." }] }
  }
}
```

- Error strings are normalized (paths → `<path>`, urls → `<url>`, numbers →
  `N`) so the same class groups.
- Known patterns shipped by `oc-error-scan`: `path_guessing`, `url_404`,
  `jq_parse`, `ado_auth`, `grep_include`, `user_abort`.
- Known sensors: `oc-error-scan` (opencode SQLite DB). A `claude-error-scan`
  (Claude Code JSONL sessions under `~/.claude/projects/`) does not exist yet
  — flag it as a coverage gap and propose it as a new script.
- The runner names the sensor and window in the prompt. Tag every class with
  its source client in the plan doc.

## Normalize tool names across clients

Clients name tools differently. Map to canonical names **before** grouping, or
the same failure splits into two classes:

| Canonical | opencode | Claude Code |
| --- | --- | --- |
| read | read | Read |
| write | write | Write |
| edit | edit | Edit |
| bash | bash | Bash |
| grep | grep | Grep |
| glob | glob | Glob |
| webfetch | webfetch | WebFetch |
| task | task | Task |
| question | question | AskUserQuestion |
| todowrite | todowrite | TodoWrite |

## Classify every error class

Label each class exactly one of:

- **deterministic** — reproducible; a script or instruction change removes it.
- **non-deterministic** — judgment- or context-dependent. Decompose it (below).
- **user-driven** — the user's own intent, not an agent failure: aborts,
  permission rejections, dismissed questions, task cancellations, no-op edit
  guards. Report them, but propose no fix (except where config friction can be
  tuned deliberately).

Frustration/profanity stats are the **symptom metric**, not a fix class. Use
them as context: which error classes correlate with bad sessions.

## Decompose non-deterministic classes

For every non-deterministic class, break it into smaller steps and re-classify
each step. Repeat until every leaf is either:

- **deterministic-fix** — a concrete script/instruction/hook removes it, or
- **judgment-bound** — genuinely model judgment; propose a skill or
  instruction improvement.

Draw the decomposition as a tree in the plan doc and label every leaf.

## Resolve deterministic classes

For every deterministic class, map it to an **existing** script or instruction
(check `~/.claude/scripts-reference.md`, the global rules in AGENTS.md, and the
scripts in `~/bin`) or propose a **new** one. Every proposal carries a
destination and its nix source path (edit the source, never the `~/bin` or
`~/.claude` symlink copies):

| Destination | Source path + wiring |
| --- | --- |
| helper script | `~/git/github/setup/nix/bin/<name>` + entry in `nix/bin/default.nix` |
| global instruction | `~/git/github/setup/nix/ai/shared/global-rules.md` (feeds both clients) |
| skill | `~/git/github/setup/nix/ai/claude/skills/<name>/SKILL.md` + `ai/claude/default.nix` |
| opencode plugin/agent | `~/git/github/setup/nix/ai/opencode/` + `ai/opencode/default.nix` |
| Claude Code config | `~/git/github/setup/nix/ai/claude/` + `ai/claude/default.nix` |

Check this meta-pattern first: **the rule already exists but the model keeps
violating it** (e.g. `grep --include`, `az … 2>&1 | jq`, guessing paths,
editing without reading). Instructions alone did not remove it. The
deterministic fix is *enforcement*: a `tool.execute.before` plugin hook
(opencode) or a `PreToolUse` hook (Claude Code) that blocks or rewrites the
known-bad call.

## Ship steps (the nix pipeline)

Every proposal lists these exact steps. The human approves and runs them; you
never commit, never run `sudo ./scripts/switch.sh`, never edit the `~/bin` or
`~/.claude` copies.

1. Edit the source file(s) under `~/git/github/setup/nix/`.
2. `git add` the new/changed files (untracked files are invisible to the nix
   build).
3. Validate from `nix/`: `./scripts/check.sh` and `./scripts/eval.sh`.
4. Commit (only with explicit user approval).
5. `sudo ./scripts/switch.sh` (the user runs this; sudo is not delegated).
6. Restart the client(s) — opencode and Claude Code load skills/config once at
   startup.
7. Verify: re-run the sensor; the targeted class counts must drop.

## Plan doc contract

Write exactly this structure to the output path:

```markdown
# Improvement suggestions — <date> (<window>)

## Coverage
- Sensors run: <name> (<what it reads>), window <since>..today
- NOT covered: <clients without a sensor — propose the sensor script>
- <N> tool errors and <M> user messages scanned

## Error classes
| # | Class | Count | Source | Type | One-line note |

## Decomposition trees (non-deterministic classes)
<class>: <tree with leaves labeled deterministic-fix / judgment-bound>

## Proposals
### <class or meta-class>
- Destination: <one of the destinations above>
- Reuse: <existing script/instruction> or New: <name>
- Ship steps: 1..7 (short form)
- Rationale: <why this removes the class>

## Verification plan
- Re-run <sensor> after shipping; targeted classes must drop toward zero.
- Frustration % is the symptom metric; it should fall with the classes.
```

## Hard constraints

- Read-only against session data. Never modify sessions, scripts,
  instructions, skills, or nix config.
- Never commit, never push, never run `switch.sh`.
- Your only durable output is the plan doc at the given path.
- If any step fails, stop and report. Never emit a partial plan doc as if the
  run succeeded.