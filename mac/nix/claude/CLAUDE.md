# Global CLAUDE.md

## General

- Be direct. Challenge bad ideas.
- Ask, don't assume.

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

### Workflow

1. Create branch: `git switch -c <type>/branch-name`
2. Make changes
3. Run tests (must pass)
4. Commit

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

### Work Item Linking

- Reference: `#<id>` in commit message
- Close on merge: `Fixes #<id>`
- Never close work items manually via API
