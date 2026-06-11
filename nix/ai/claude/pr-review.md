# PR Code Review — C#/.NET

Structured multi-pass code review for C#/.NET pull requests in Azure DevOps.

## Prerequisites

### Param File

Config is persisted per ADO project at `~/.claude/pr-review/<org-name>-<project>.json`.

**Schema:**

```json
{
  "org": "https://dev.azure.com/<org>",
  "project": "<project>",
  "repository": "<repo-name>"
}
```

### Step 1: Auto-discover from git remote

Parse the git remote URL to extract org, project, and repository:

```bash
git remote get-url origin
```

ADO remote URL formats:
- `https://dev.azure.com/<org>/<project>/_git/<repo>`
- `https://<org>@dev.azure.com/<org>/<project>/_git/<repo>`
- `git@ssh.dev.azure.com:v3/<org>/<project>/<repo>`

Extract `org`, `project`, and `repo` from the URL. If the remote doesn't match any ADO pattern, fall back to Step 2.

### Step 2: Load or create param file

If auto-discovery succeeded, check for an existing param file at `~/.claude/pr-review/<org-name>-<project>.json`.

**If param file exists** → read it, compare with auto-discovered values. If they match, use them. If they differ, ask the user which is correct and update the file.

**If param file does not exist** → create it from the auto-discovered values. Confirm with the user before saving.

**If auto-discovery failed** → check for existing param files:

```bash
ls ~/.claude/pr-review/*.json 2>/dev/null
```

If param files exist, list them as options. Otherwise, ask the user for org, project, and repository name.

### Step 3: Verify access

```bash
az repos pr show --id <PR_NUMBER> --org "$ORG" -o json
```

If this fails, the org/project/PR values are wrong. Stop and ask the user to correct them.

### Step 3.5: Make the working tree FRESH (MANDATORY — do not skip)

**Never check out a PR branch on top of a stale tree or stale dependencies.** A stale `node_modules` / `bin/obj` makes `tsc`, `eslint`, `dotnet build`, and tests produce garbage ("Cannot find module", phantom errors) that look like PR defects but are environment noise. This step is mandatory and must complete BEFORE checking out the PR branch.

1. Confirm a clean tree: `git status --porcelain`. If there are uncommitted/untracked changes that are not yours, stop and ask. (A single unrelated untracked file you can note and leave.)
2. Switch to the repo's default branch and update it:
   ```bash
   git switch <default-branch>      # main or dev — read from the PR's targetRefName
   git fetch origin <default-branch> <pr-source-branch>
   git pull --ff-only
   ```
3. **Install dependencies fresh, deterministically, from the default branch state**, using the repo's own lockfile/manifest. Detect the toolchain and run the frozen install BEFORE switching branches, then again AFTER checking out the PR branch if the lockfile changed in the PR:
   - pnpm: `pnpm install --frozen-lockfile`
   - npm: `npm ci`
   - yarn: `yarn install --immutable`
   - .NET: `dotnet restore`
   Run installs from the directory that owns the manifest (e.g. `src/frontend`), not the repo root, if they differ.
4. Now check out the PR source branch. **If the PR changed the lockfile/manifest (e.g. `package.json`, `pnpm-lock.yaml`, `*.csproj`), run the frozen install AGAIN on the PR branch** so new dependencies are present.
5. Only after deps are fresh on the PR branch may you run `tsc`/`eslint`/`dotnet build`/tests. If any tool reports "module not found" or unresolved imports for a dependency the PR adds, your environment is still stale — re-install, do not report it as a finding.

If a fresh install is impossible (e.g. private registry auth unavailable), STOP and tell the user; do not run build/lint/type tools against a stale tree and do not present their output as review findings.

### Step 4: Set per-run params

These change each run and are NOT stored in the param file:

- PR number — from the user's request

Store session variables:
```bash
ORG="<from param file>"
PROJ="<from param file>"
REPO="<from param file>"
PR_NUMBER="<from user>"
```

Read `~/.claude/ado_cli_reference.md` for ADO CLI flag rules and PR thread API structure.

### Step 5: Fetch linked work item

Extract the work item ID from the PR title (e.g., `#80289`). Fetch it and verify the code changes match the requirements:

```bash
az boards work-item show --id <WORK_ITEM_ID> --org "$ORG" -o json
```

---

## Phase 1 — Initial Best Practice Analysis

Examine every changed file in the PR. For each finding, report:

| # | File | Line(s) | Severity | Category | Finding | Suggestion |
|---|------|---------|----------|----------|---------|------------|

Categories: Code Quality, Naming, Dead Code, Readability, Correctness, Style, Performance, Security.

Severity levels:
- **HIGH** — Likely runtime error, data corruption, security issue, or zero test coverage on critical logic. Must fix before merge.
- **MEDIUM** — Code smell, maintainability concern, missing test case for new branch. Should fix, can negotiate.
- **LOW** — Typo, cosmetic, missing doc comment, naming preference. Nitpick — fix if convenient.

---

## Phase 2 — Compare with Existing Reviewer Comments

Get all existing review comments on this PR and compare them to your findings.

For each human reviewer thread, check:
- Does it overlap with an AI finding? (match)
- Is it something the AI missed? (gap)
- Did the AI find something the reviewer didn't? (additional)

Output a comparison matrix showing coverage overlap and unique findings from both sides.

---

## Phase 3 — Cyclomatic Complexity & Maintainability Index

Do a pre/post cyclomatic complexity and maintainability index check on the affected C# files.

Workflow:
1. Stash any local changes
2. Checkout base branch (detached HEAD) and run code metrics on affected files
3. Checkout the feature branch and repeat metrics
4. Restore the original branch and pop stash

Present results as:

| File | CC Pre | CC Post | Delta | LoC Pre | LoC Post | MI Pre | MI Post |
|------|--------|---------|-------|---------|----------|--------|---------|

Flag any file where:
- CC increases by >5
- MI drops below 25
- A new file is introduced with CC >10

---

## Phase 4 — Improvement Suggestions

For the top 3 most-affected files (by CC/MI regression), read the full source and propose concrete refactorings:
- Extract method / class
- Simplify switch/ternary logic
- Remove duplication
- Break up god classes

Include:
- Before/after code sketches
- Expected CC/MI impact estimates
- Risk assessment (safe for this PR vs follow-up)

---

## Phase 5 — Test Coverage Verification

For every changed production file, find the corresponding test file(s). Check:
- Do tests exist for the new/changed logic?
- Are any tests commented out or marked obsolete?
- Are new branches (enum values, switch cases) covered by test data?
- Are edge cases tested (null, zero, boundary)?

If test coverage gaps are found, report them with specific suggestions for what test cases to add.

---

## Phase 6 — Comprehensive Checklist

Run a 5-category checklist:

### Code Functionality
- [ ] New logic handles all enum/switch branches (no silent `default: break`)
- [ ] Null guards on nullable types before `.Value` access
- [ ] No `NullReferenceException` paths introduced
- [ ] Domain invariants preserved (e.g., status transitions are valid)
- [ ] Side effects are intentional (DB saves, message publishing)
- [ ] Filter/query logic uses correct boolean operators (`&&` vs `||`)

### Code Style and Standards
- [ ] No unused `using` directives
- [ ] No dead code (`|| false`, unreachable branches)
- [ ] Naming follows conventions (methods, classes, variables)
- [ ] No test-only dependencies in production code (e.g., `Bogus`)
- [ ] No duplicated constants or magic numbers
- [ ] `.editorconfig` / analyzer rules respected

### Testing and Validation
- [ ] New classes have corresponding unit tests
- [ ] New enum values appear in test data (`[InlineData]`, `[MemberData]`)
- [ ] No tests are commented out without replacement
- [ ] Edge cases covered: null, zero, empty, boundary values
- [ ] Integration/handler tests cover the happy path

### Documentation
- [ ] Public enum values have XML `<summary>` comments
- [ ] XML doc comments are well-formed (no stray tags)
- [ ] Log messages are spelled correctly
- [ ] Complex business logic has explanatory comments

### Security
- [ ] No secrets, tokens, or connection strings in code
- [ ] Input validation on public endpoints
- [ ] Authorization checks in place for new endpoints
- [ ] No SQL injection vectors (parameterized queries used)

---

## Phase 7 — Post Comments

Post all findings as PR comments.

Rules for posting:
- **Every comment MUST start with "AI:"** to clearly indicate it was generated by an AI assistant
- Anchor comments to the specific file and line range
- HIGH and MEDIUM findings: Active thread, prefix with "AI:"
- LOW findings: Active thread, prefix with "AI: Nitpick:"
- If a finding overlaps with an existing reviewer comment, reply to that thread instead of creating a new one
- Group related findings when they're on adjacent lines

---

## Phase 8 — Documentation Check

Evaluate whether the PR should trigger documentation updates:
- Does the change affect `readme.md` (new dependencies, changed commands, project structure)?
- Should any documentation be updated?
- Are new endpoints or configuration options documented?

Report any documentation gaps found.

---

## Phase 9 — Create Observation File

Create a code review observation file containing:
1. PR metadata (number, branch, date, scope)
2. CC/MI metrics table (pre/post)
3. Reviewer comments summary with author responses
4. Improvement suggestions with code sketches and expected impact
5. Test coverage gaps

This serves as a historical record and input for follow-up work items.

---

## Behavior Rules

- **Always prefix** every PR comment with "AI:" or "AI: Nitpick:"
- **Never commit secrets** — run `gitleaks detect` before every commit
- **`git switch -c`** not `git checkout -b`
- **Conventional commits**: `fix(<scope>): <description>` for any fix branches
- **ADO `update`**: uses `--org` only, NO `--project`
- **ADO PR comments**: use the thread API structure from the ADO CLI reference
- **Never flag "missing trailing newline"** — this is not a valid finding. Do not mention it, post it, or suggest it in any review.
