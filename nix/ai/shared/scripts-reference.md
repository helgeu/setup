# Helper scripts reference

Task-oriented map of the custom helper scripts on this machine so the agent
reaches for an existing tool instead of hand-rolling `az`/`jq`/`git`.

Source of truth: `~/git/github/setup/nix/bin` (bash/python, symlinked into
`~/bin`) and `~/git/github/setup/nix/ai/claude/ado` (PowerShell, symlinked into
`~/.claude/ado`). Never edit the `~/bin` or `~/.claude` copies — edit the nix
source and rebuild.

## Pick a script by task

| I want to… | Use | Notes |
| --- | --- | --- |
| List **all** active PRs for the repo I'm standing in (any author) | `find-prs` | Derives org/project/repo from the current git `origin`. Must be run inside a clone. |
| Fan out an AI review across every active PR in the current repo | `find-prs --review` | One `pr-review` per PR, each in its own tmux window. |
| List **my** open PRs across **all** projects in an org | `azprs <org>` | e.g. `azprs urholm`. Not repo-bound; spans the whole org. |
| AI-review a single PR by id (produces JSON findings, posts nothing) | `pr-review <id> [org]` | Isolated worktree + clean install, then the opencode `pr-review` agent. |
| Publish reviewed findings to the PR | `pr-review-post <findings.json>` | Reads the JSON `pr-review` wrote; supports `--dry-run` / `--yes`. |
| Choose an opencode model + reasoning variant interactively | `pr-model-select` | Shared chooser used by `find-prs`/`pr-review`; rarely called directly. |
| List open work items assigned to me (or someone) | `ado-my-items` | Defaults `urholm`/`Devkunt`/`@me`; `-o -p -a -f`. |
| Create child Tasks under user stories from a JSON plan | `ado-create-tasks <tasks.json>` | Idempotent (skips existing titles); `--dry-run` / `--yes`. |
| Approve a pipeline ManualValidation gate (promote dev→test/qa/prod) | `ado-approve-deploy --build <id> --stage test` | Resumes a paused `ManualValidation@0` stage. `--list`, `--pipeline`, `--branch`, `--reject`, `--dry-run`. Defaults imdidev/Bosettingsprosjekt. |
| Run opencode against a local Ollama model | `oc [model]` | `oc` = qwen3.6, `oc coder` = qwen3-coder:30b; extra args pass through. |
| Recap activity for a standup (done / next / blockers) | `standup [today\|yesterday\|week\|--days N] [--json]` | Reads the local opencode session DB. Pairs with the `standup` skill for ADO cross-ref. |
| Create one ADO work item (optionally parent-linked) | `New-AdoWorkItem.ps1` | `-Config <org>-<project> -Type -Title [-ParentId -Tags]`. |
| Seed an Epic/Feature hierarchy from a backlog JSON | `Import-AdoBacklog.ps1` | Idempotent; `-Backlog file.json [-WhatIf]`. |
| Pull the live board to `backlog.json` + `Backlog.md` | `Export-AdoBacklog.ps1` | ADO is master; generated files, never hand-edit. |
| Apply backlog ordering (StackRank) from a backlog file | `Set-AdoBacklogOrder.ps1` | File order = backlog order (top of file = top of backlog). |

## Details

### PR tooling (`~/bin`, bash)

- **`find-prs`** — active PRs for the current repo (auto-detected from `origin`;
  supports dev.azure.com, ssh v3, and `*.visualstudio.com`). Formats:
  `--format links|markdown|plain|json`. `-C <dir>` to target another clone
  without `cd`. `--review [-m <model>] [--variant <v>]` spawns one `pr-review`
  tmux window per PR. Skips drafts. Auto-runs `az login` if the token is stale.
- **`azprs <org> [creator]`** — *my* active PRs across *every* project in an org
  (creator defaults to the `az` signed-in user). Output format via `-f/--format`
  (`links|markdown|plain|json`) or `AZPRS_FORMAT`; creator via `-c/--creator` or a
  second bare arg. Unknown flags now error instead of being swallowed as the
  creator. Use this for "check all my PRs", not `find-prs` (which is single-repo).
- **`pr-review <id> [org] [-m <model>] [--variant <v>] [--keep]`** — maps a PR
  id to its local clone under `~/ado` (override with `PR_REVIEW_REPO_ROOTS`),
  checks the source branch out in a fresh **isolated worktree** (never touches
  your tree/branches), installs deps, runs the opencode `pr-review` agent, and
  writes `~/.claude/pr-review/PR-<id>-findings.json`. Posts nothing.
- **`pr-review-post <findings.json> [--dry-run] [--yes]`** — posts findings with
  `post != false` as anchored PR threads (or replies). Review/edit the JSON
  first. `--dry-run` prints payloads.
- **`pr-model-select`** — interactive model+variant chooser (github-copilot
  opus/gpt, enumerated live from `opencode models`). Prints `<model>\t<variant>`
  on stdout; menus/logs go to stderr. Mostly an internal helper.
- **`oc [model] [opencode args…]`** — opencode against local Ollama. Aliases:
  `oc`/`oc general` → qwen3.6, `oc coder` → qwen3-coder:30b. Requires
  `ollama serve` reachable on :11434.

### ADO work items

- **`ado-my-items` (bash)** — WIQL "my items" (assigned, not
  Closed/Removed/Resolved/Ready for Production). `-o org -p project -a assignee
  -f table|json`. Defaults `urholm`/`Devkunt`/`@me`.
- **`ado-create-tasks <tasks.json>` (python)** — creates child Tasks under user
  stories; inherits parent Area/Iteration; idempotent by title. `--dry-run`,
  `--yes`. JSON shape documented in the script header.
- **`ado-approve-deploy` (bash)** — approves/rejects a paused
  `ManualValidation@0` gate so a deploy stage proceeds (e.g. promote the latest
  dev deploy to test). `--build <id>` or `--pipeline <id|name> [--branch main]`
  to find the latest run; `--stage <substr>` (test/qa/prod), `--list`,
  `--reject`, `-m`, `--dry-run`. The non-obvious bit it encapsulates: resume the
  task via the **Approvals-Update** API keyed by the timeline record's
  `identifier` (there is no `distributedtask/manualvalidations` route). Details
  in `ado-cli-reference.md` → "Approving a ManualValidation gate".
- **PowerShell backlog toolkit (`~/.claude/ado/*.ps1`)** — all take
  `-Config <org>-<project>` matching a file in `~/.claude/ado/configs/`
  (nix-generated). `New-AdoWorkItem`, `Import-AdoBacklog` (seed, `-WhatIf`),
  `Export-AdoBacklog` (board → JSON + wiki md), `Set-AdoBacklogOrder`
  (StackRank). `Ado.Common.ps1` holds shared helpers (config load, login
  assert, title/id lookups).

## Gotchas

- **zsh doesn't word-split unquoted variables.** Looping over a space-separated
  string (`for d in $repos`) treats the whole string as one item. Use a real
  array (`repos=(a b c); for d in $repos`) or `${=repos}`.
- **`find-prs` is single-repo; `azprs` is org-wide.** For "all my PRs" reach for
  `azprs <org>`. To sweep many local clones with `find-prs`, iterate with
  `-C <dir>` over an array of repo dirs.
- **`pr-review` never posts; `pr-review-post` does.** Two steps on purpose:
  generate/inspect JSON, then publish.
- **Most scripts auto-run `az login`** when the ADO token is missing, but that
  needs a TTY. In headless contexts ensure a valid `az` session first.
- The `az`/ADO CLI flag rules and PR-thread API live in
  `~/.claude/ado-cli-reference.md` — read it before non-trivial `az boards`/PR
  thread work.
