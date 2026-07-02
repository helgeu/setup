---
name: pr-review
description: Structured multi-pass code review for C#/.NET (and frontend) Azure DevOps pull requests. Use when reviewing an ADO pull request, when asked to "review PR <id>", or when driven headlessly by the `pr-review` script. Produces a structured JSON findings file; it does NOT post comments (a separate `pr-review-post` script does that).
---

# PR Review — structured findings (no posting)

You perform a structured multi-pass code review of an Azure DevOps pull request
and emit the result as a **single JSON findings file**. You do **not** post any
comments — posting is a separate, human-approved step handled by the
`pr-review-post` script.

## Inputs you are given

When invoked by the `pr-review` script you receive, in the prompt:

- A **PR context file** (`PR-<id>-context.json`) — the verified output of
  `az repos pr show`, pre-fetched by the script. Trust it. It contains the PR
  id, repository name + id (GUID), `sourceRefName`, `targetRefName`, and the
  source commit. **Read it; do not re-fetch this metadata.**
- The **checked-out worktree** is already the PR source branch, on a fresh tree
  with dependencies installed. Do not switch branches except for the metrics
  phase (and restore afterwards).
- The **output path where you must create** the findings JSON, typically
  `PR-<id>-findings.json`. This file is not expected to exist before the
  review runs.

If any of these are missing, stop and report — do not guess.

## Reference material

- Full phase-by-phase playbook: `~/.claude/pr-review.md` (Phases 1–9). Follow
  its analysis phases. The **only** deviation: Phase 7 ("Post Comments") is
  replaced by "Emit findings JSON" below — you never post.
- ADO CLI rules + PR thread API + the **iteration-changes API** (for
  `changeTrackingId`): `~/.claude/ado-cli-reference.md`.

## Workflow

1. If you need to run Azure DevOps CLI/REST calls directly, first verify login
   with `az account get-access-token --resource 499b84ac-1321-427f-aa17-267ca6975798`.
   If no token is available, run `az login --allow-no-subscriptions` yourself
   before continuing. When invoked by the `pr-review` script, this preflight has
   already happened before the context file was generated.
2. Read the PR context file. Extract `org`, `project`, `repository`,
   `repositoryId`, PR id, source/target branch.
3. **File scope (mandatory):** use the iterations/changes REST API from the ADO
   reference — never a raw `git diff` between branches. Capture, per changed
   file, its `changeTrackingId` and the iteration ids — the poster needs these
   to anchor comments.
4. Fetch the linked work item (id from the PR title, e.g. `#80289`) and verify
   the code matches its requirements.
5. Run the analysis phases from the playbook:
   - Phase 1 — best-practice analysis of every changed file
   - Phase 2 — compare with existing reviewer threads (read them via the
     `pullRequestThreads` API; mark overlaps so the poster can reply instead of
     duplicating)
   - Phase 3 — cyclomatic complexity / maintainability index pre vs post
   - Phase 5 — test-coverage verification
   - Phase 6 — the 5-category checklist
   - Phase 8 — documentation check
6. Write the findings JSON (schema below) to the given output path.
7. Optionally also write the Phase 9 observation markdown to
   `~/.claude/pr-review/PR-<id>-observation.md` (historical record). This is
   allowed; it is not a PR comment.

## Findings JSON contract

Write exactly this shape to the output path. This is the contract the
`pr-review-post` script consumes.

```json
{
  "pr": {
    "id": 22846,
    "org": "https://dev.azure.com/imdidev",
    "project": "Bosettingsprosjekt",
    "repository": "resettlement-apps",
    "repositoryId": "00000000-0000-0000-0000-000000000000",
    "sourceBranch": "refs/heads/feature/x",
    "targetBranch": "refs/heads/main",
    "iteration": { "first": 1, "second": 3 }
  },
  "generatedAt": "2026-06-11T10:00:00Z",
  "summary": "One-paragraph overall assessment.",
  "findings": [
    {
      "id": "F1",
      "file": "/src/Foo/Bar.cs",
      "lineStart": 42,
      "lineEnd": 48,
      "offsetStart": 1,
      "offsetEnd": 1,
      "severity": "HIGH",
      "category": "Correctness",
      "title": "Null dereference on optional value",
      "comment": "AI: `Bar.Value` is read without a null guard; ...",
      "changeTrackingId": 5,
      "replyToThreadId": null,
      "status": "active",
      "post": true
    }
  ]
}
```

Field rules:

- `file` — repo-relative path with a **leading slash**, exactly as the ADO
  `threadContext.filePath` expects.
- `lineStart`/`lineEnd` — 1-based lines on the **right** (PR) side of the diff.
  `offsetStart`/`offsetEnd` default to `1`.
- `severity` — `HIGH` | `MEDIUM` | `LOW`.
- `category` — Code Quality, Naming, Dead Code, Readability, Correctness, Style,
  Performance, Security, Testing, Documentation.
- `comment` — the full comment body. **Prefix every comment with `AI:`**; for
  `LOW` severity use `AI: Nitpick:`. Never use backticks-as-command-substitution
  concerns here — this is JSON, just plain text.
- `changeTrackingId` — from the iteration-changes API for that file. Required
  for anchored comments; if you genuinely cannot resolve it, set it to `null`
  and the poster will create a floating thread.
- `replyToThreadId` — if this finding overlaps an existing reviewer thread, put
  that thread id here so the poster replies instead of creating a duplicate.
  Otherwise `null`.
- `status` — `active` (`1`) for HIGH/MEDIUM/LOW; the poster maps it.
- `post` — `true` by default. The human may flip findings to `false` (or edit
  text / lines) before running the poster.

## Rules

- **Never post comments** — emit JSON only.
- **Never flag "missing trailing newline"** — not a valid finding.
- Read-only against ADO: `show`, `pullRequestThreads` GET, iteration-changes
  GET, work-item `show`. No writes.
- Do not `git push`, do not create branches, do not edit source files in the
  worktree (except the metrics-phase checkout, which you must restore).
- All shell commands run under `bash`, not `zsh`.
- If any step fails, stop and report — do not continue producing partial
  findings as if the run succeeded.
