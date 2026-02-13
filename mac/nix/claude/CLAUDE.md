# Global CLAUDE.md

Global rules for all projects.

## Git

### Branches

- Use `git switch` instead of `git checkout`
  - Create and switch: `git switch -c branch-name`
  - Switch to existing: `git switch branch-name`
- Branch prefix must match commit type: `feat/`, `fix/`, `docs/`, `refactor/`,
  etc.

### Commits

Follow [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/):

```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

**Types:**

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

**Rules:**

- Use imperative mood: "add" not "added" or "adds"
- No period at end of subject line
- Keep subject line under 72 characters

**Breaking changes:** Add `!` after type/scope:
`feat(api)!: change response format`

**Examples:**

- `feat: add multi-arch Docker build support`
- `fix(auth): handle expired tokens gracefully`
- `docs: add gh CLI commands to README`
- `chore(deps): bump @azure-devops/mcp to 2.5.0`

## GitHub

- Prefer `gh` CLI over web UI or raw API calls
- Use `gh repo create`, `gh pr create`, `gh run list`, `gh workflow run`

## Docker

- Always build multi-architecture images: `linux/amd64,linux/arm64`
- Use QEMU in GitHub Actions for cross-platform builds
- Include `docker/setup-qemu-action@v3` before `docker/setup-buildx-action@v3`

## Azure DevOps

### User Stories

- Follow format: "As a [role], I want [goal], so that [benefit]"
- Keep titles concise and action-oriented

### Acceptance Criteria

Use Gherkin syntax:

```gherkin
Scenario: [Scenario name]
  Given [precondition]
  When [action]
  Then [expected result]
```

### Work Item Linking

- Reference work items: `#<id>` in commit message
- Close on merge: `Fixes #<id>`
- Never close work items manually via API
