# Global agent rules

<!-- Canonical, tool-neutral global instructions shared by all AI coding agents.
     Claude Code consumes this as ~/.claude/CLAUDE.md (via RTK baseClaude, which
     also appends the RTK command reference). OpenCode consumes the same file as
     ~/.config/opencode/AGENTS.md. Keep this file free of tool-specific syntax
     and do NOT write the RTK include token here: RTK skips appending its
     reference if the base content already mentions it. Per-tool packaging lives
     in ai/claude and ai/opencode. -->

## General

> **Helper scripts:** Before hand-rolling `az`/`jq`/`git`/PR/backlog logic, check
> `~/.claude/scripts-reference.md` — a task→script map for the custom tools on
> this machine (`find-prs`, `azprs`, `pr-review`, `pr-review-post`, `ado-my-items`,
> `ado-create-tasks`, `oc`, and the PowerShell ADO backlog toolkit). Prefer an
> existing script over improvising.

- Be direct. Challenge bad ideas.
- Ask, don't assume.
- **Resolve ambiguity before acting.** When an instruction could lead to meaningfully different outcomes depending on interpretation, ask before acting.
- **Locate before you read; never guess paths.** Resolve real file paths with a search/glob first — do not fabricate or guess filenames, casing, or directory layout. (Repos here are typically flat: don't assume a `src/` folder.) If a path isn't found, search for it once and use the real result; don't retry invented variations.
- **Never fabricate URLs.** Only use URLs the user gave you, that appear in local files, or that you obtained from a search/API. If you don't know a URL, search for it — never guess. Always hand back full, clickable links to PRs, work items, builds, and docs so they can be opened directly.
- **Be surgical. Scope down.** Deliver the smallest change that solves the ask; don't bundle speculative refactors, extra features, or ELI5 padding. When a suggestion grows large, cut it back and confirm scope before proceeding.
- **Don't ask for what you can fetch.** If data is reachable via a tool/CLI/API you already have (e.g. Azure DevOps via `az`), retrieve it yourself instead of asking the user to paste it. Reserve questions for genuine decisions, not lookups.
- **Kick off non-trivial tasks with a spec.** Before starting any ambiguous or multi-step task, use the `kickoff` skill: uncover the real goal, restate it as goal + small steps + done-criteria, and get approval before building. Don't jump to artifacts before understanding.
- **Persist progress for long/multi-step work.** Write a resume doc to a file (discovery, the plan, and the todo list) so the work survives an interruption or context reset — don't rely on being told "resume" and reconstructing from memory. Likewise, when you learn a hard-won fact (an env quirk, a fix, a gotcha), document it in the right file so it isn't rediscovered every time.
- Never suggest manual work. Automate everything - create scripts, write code, handle it directly. Exception: sudo commands (password required).
- **Do the work yourself; never hand it back.** You are here to *do* the task, not to tell the user to run/test/check it. If you can run it, test it, read the logs, or fetch the data — do it, then report the result. Don't stop at "you should run X" or "please check Y". The only things to defer to the user are genuine decisions, sudo/password prompts, and interactive browser auth.
- **Never work around problems. Always fix the root cause.** Workarounds hide issues, create technical debt, and cause bigger problems later. Diagnose why something is broken and fix it properly.
- **Never change configs randomly.** All configuration changes must be done through the nix setup at `~/git/github/setup/nix`. This ensures reproducibility and proper management.
- **Trust the existing setup.** Before adding workarounds or overrides, try the operation first. The system is configured correctly - understand how it works before assuming it's broken.
- **Keep shell commands RTK-rewritable.** RTK (the token-saving proxy) only rewrites simple, piped, and `&&`-chained commands. It passes through *unrewritten* any rtk-eligible command (`cat`, `grep`, `ls`, `find`, `git`, `curl`, …) buried inside a `for`/`while` loop, a `$(…)`/backtick substitution, `xargs`, or a large multi-statement block (upstream limitation: rtk-ai/rtk#1252). So prefer native file/search tools or atomic, single-purpose commands over packing inspection logic into compound shell blocks — otherwise the token savings are silently lost.
- **Search with the dedicated grep tool or `rg`, never `grep --include`.** RTK rewrites `grep`→`rg`, so grep-only flags break: `grep --include=<glob>` fails (rg has no `--include`; it maps toward `-E` → "unknown encoding", and unquoted globs get eaten by the shell). Prefer the agent's grep/glob tools. If you must shell out, use ripgrep glob syntax: `rg -g '*.ts' <pattern>` (quote the glob), and `rg --files -g '<glob>'` to list files.
- **On macOS (darwin), `python` and `timeout` do not exist.** Use `python3` (never bare `python`). There is no `timeout`/`gtimeout` — don't wrap shell commands in `timeout …`; use the bash tool's own `timeout` parameter instead. Assume BSD variants of `sed`/`date`/etc., not GNU flags.

## Editing files

- **Never add a trailing newline to any file.** Files must not end with a trailing blank line. Do not introduce EOF newlines, and never add blank lines the change does not require. This is a hard, standing rule — never re-litigate it.
- **Never reformat or re-indent lines you are not functionally changing.** Touch only what the task requires; gratuitous whitespace/format churn is noise.
- **Read a file before editing or overwriting it.** Never edit blind.
- **Make edit anchors unique and non-empty.** Give the match enough surrounding context to be unambiguous, and never submit an edit whose new content is identical to the old (a no-op edit is an error).

## Never Do (Absolute)

### No Secrets in Commits

- Never commit passwords, API keys, tokens, or secrets
- Verify no secrets before every commit
- Scan commit diff for sensitive patterns

### Never Commit These Files

```
# Environment & secrets
.env
.env.*
*.local

# .NET
appsettings.json
appsettings.*.json
secrets.json
*.user

# Certificates & keys
*.pem
*.key
*.pfx
*.p12
*.keystore
id_rsa*
id_ed25519*

# Cloud credentials
.aws/
.azure/
gcloud/
serviceAccountKey.json
credentials.json
kubeconfig

# Package manager tokens
.npmrc
.pypirc
.netrc
```

### Enforcement

- Ensure files above are in `.gitignore`
- Use `gitleaks` for secret scanning (required)
- Run `gitleaks detect` before every commit
- Run `git diff --cached` to review staged changes

## Git

### Branches

- Use `git switch` instead of `git checkout`
  - Create and switch: `git switch -c branch-name`
  - Switch to existing: `git switch branch-name`
- Branch prefix must match commit type: `feat/`, `fix/`, `docs/`, `refactor/`, etc.

### Before you start (mandatory)

1. **Fetch latest and start fresh.** Before any git work, sync and branch from an up-to-date default branch:
   ```bash
   git fetch origin
   git switch main && git pull --ff-only      # or the repo's default branch
   git switch -c <type>/branch-name
   ```
   Never start work on a stale branch or one whose state you haven't verified.
2. **Never build on a dirty or untrusted branch.** If the current branch carries unrelated or uncertain changes, do not pile onto it — start over from a fresh branch off updated `main` and drop the old work. When in doubt, redo from `main`.
3. **Commit checkpoints.** Commit each working increment before switching context or continuing, so nothing is lost and state stays inspectable. If asked "did you commit / branch?", the answer must already be yes.

### Workflow

1. Start fresh from updated default branch (see above): `git switch -c <type>/branch-name`
2. Make changes
3. **Verify locally before committing (see next section) — build, tests, lint, analyzers must pass**
4. Commit

### Verify before commit/push (mandatory)

- **Run the project's full local checks BEFORE you commit or push** — build, tests, formatter/linter (e.g. prettier/eslint), and static analyzers (SonarCloud rules, Roslynator). Prove they pass locally.
- **Never push and let the pipeline find failures.** Pipeline round-trips are slow and expensive; a red build that a local run would have caught is a process failure.
- For .NET specifics — running SonarCloud/Roslynator analyzers locally, wiring analyzers via `Directory.Build.props`/`.editorconfig`, and common `Sxxxx` rule gotchas — see `~/.claude/dotnet-reference.md`.

### Commits

[Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/): `<type>(<scope>): <description>`

| Type       | Description                        |
| ---------- | ---------------------------------- |
| `feat`     | New feature                        |
| `fix`      | Bug fix                            |
| `docs`     | Documentation only                 |
| `style`    | Formatting, no code change         |
| `refactor` | Code restructuring, no feature/fix |
| `perf`     | Performance improvement            |
| `test`     | Adding/updating tests              |
| `build`    | Build system or dependencies       |
| `ci`       | CI/CD configuration                |
| `chore`    | Maintenance tasks                  |

Rules:
- Imperative mood: "add" not "added"
- No period at end
- Max 72 characters
- Breaking changes: add `!` after type/scope → `feat(api)!: change response format`

Examples:
- `feat: add multi-arch Docker build support`
- `fix(auth): handle expired tokens gracefully`
- `docs: add gh CLI commands to README`
- `chore(deps): bump @azure-devops/mcp to 2.5.0`

## Code Review

### Required
- New code must have tests
- Tests must pass
- No secrets or forbidden files
- Commit messages follow conventions
- Work item linked

### Security
- Input validation (SQL injection, XSS, command injection)
- Authentication/authorization checks
- Secure data handling (encryption, hashing)
- Dependency vulnerabilities

### Quality
- Error handling (try/catch, null checks, edge cases)
- Logical flaws (off-by-one, race conditions, deadlocks)
- Performance (N+1 queries, unnecessary loops, memory leaks)
- Resource cleanup (dispose, close connections)

## GitHub

- Prefer `gh` CLI over web UI or API calls
- Commands: `gh repo create`, `gh pr create`, `gh run list`, `gh workflow run`

## Docker

- Always multi-arch: `linux/amd64,linux/arm64`
- GitHub Actions: `docker/setup-qemu-action@v3` before `docker/setup-buildx-action@v3`

## Swift

- Use `xcodegen` to generate Xcode projects from YAML specs
- Keep `project.yml` in version control, not `.xcodeproj`
- Run `xcodegen generate` after modifying `project.yml`

## Azure DevOps

> **CLI Reference:** Before any `az boards` work, read `~/.claude/ado-cli-reference.md` for flag rules, bulk patterns, and gotchas.

- **Never guess the org or project.** Load them from the ADO config files (`~/.claude/ado/configs/<org>-<project>.json`); the org URL is always `https://dev.azure.com/<org>`. Do not confuse similarly named orgs/projects. If the target is ambiguous or not configured, the final fallback is to **ask "which ADO org / project?"** — never assume.

### User Stories

- Format: "As a [role], I want [goal], so that [benefit]"
- Keep titles concise and action-oriented

### Acceptance Criteria

Gherkin syntax:
```gherkin
Scenario: [Scenario name]
  Given [precondition]
  When [action]
  Then [expected result]
```

### PR Reviews

- Use `az` CLI for all ADO operations. Never use `mcp__u-ado-mcp__*` tools.
- Prefix every PR review comment with `**AI: SEVERITY**` (e.g. `**AI: Warning**`, `**AI: Question**`, `**AI: Nitpick**`, `**AI: Suggestion**`, `**AI: Error**`).
- Always fetch linked work items (from PR title, e.g. `#80145`) and verify the code matches requirements.
- See `~/.claude/ado-cli-reference.md` for the correct PR thread API structure.

### Work Item Linking

- Reference: `#<id>` in commit message
- Close on merge: `Fixes #<id>`
- Never close work items manually via API
