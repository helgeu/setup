# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Repo Is

Personal multi-machine setup: Nix configurations for macOS and WSL, plus standalone Windows scripts.

## Structure

- `nix/` - Declarative system config using nix-darwin (macOS), NixOS-WSL (Windows), and home-manager (user environment). Has its own `CLAUDE.md` with nix-specific rules.
- `win/` - Standalone PowerShell scripts for Windows (winget installs, VS Code extensions). Not managed by Nix.

## Machines (defined in nix/flake.nix)

| Name | Type | User |
|------|------|------|
| NO-GLV6Y9N492 | Work Mac (nix-darwin) | helgereneurholm |
| Helges-MacBook-Pro | Personal Mac (nix-darwin) | helgeu |
| wsl-work | WSL NixOS | nixos |

## Nix Architecture

Single flake (`nix/flake.nix`) drives three layers per machine:
1. **System** (`system/*.nix`) - nix-darwin or NixOS settings, Homebrew casks, fonts
2. **Home Manager** (`home-manager/*.nix`) - User packages, shell, editor, dev tools
3. **Dock** (`dock/*.nix`) - macOS Dock layout (macOS only)

Convention: `*/shared.nix` holds cross-machine config; hostname files hold machine-specific overrides. Use `pkgs.stdenv.hostPlatform.isDarwin`/`isLinux` for platform conditionals.

Key modules imported by home-manager: `zsh.nix`, `git.nix`, `vscode.nix`, `nvf.nix` (Neovim via NVF framework), `claude.nix`, `ghostty.nix`, `lsp-servers.nix`.

## Commands

All scripts live in `nix/scripts/` and must be run from `nix/`:

```bash
# Validation (run before committing)
./scripts/check.sh        # Fast syntax check (nil)
./scripts/eval.sh         # Evaluate all 3 configs (catches type/config errors)
./scripts/nvim-check.sh   # Neovim health check (only after nvf/ changes)
./scripts/health.sh       # Audit: fork inputs, temp workarounds, stale flake ages

# Build and apply
sudo ./scripts/switch.sh  # Build + activate (macOS)
./scripts/build.sh        # Build without activating
./scripts/update.sh       # Update flake inputs

# Maintenance
./scripts/cleanup-nix.sh            # Delete generations older than 14d + GC + optimise store
./scripts/cleanup-nix.sh --all      # Delete all old generations (keep current only)
./scripts/cleanup-nix.sh --dry-run  # Preview what would be freed

# WSL
sudo nixos-rebuild switch --flake .#wsl-work
```

Which checks to run depends on what changed:
- Any `.nix` file: `check.sh` + `eval.sh`
- `nvf/` changes: also `nvim-check.sh`
- `system/` changes: full rebuild to verify

## Workflow

1. Make changes
2. Run validation scripts (must pass)
3. Commit (only if checks pass)
4. User rebuilds and verifies manually - never mark done until confirmed

## Key Rules

- **Prefer `programs.X` modules** over `home.packages` when home-manager provides one
- **Verify packages exist** before adding: `nix eval nixpkgs#<name>.meta.description`
- **Small, incremental changes** - one logical change at a time
- **Don't batch unrelated changes** - isolate failures
- **Never run `darwin-rebuild` directly** - use `scripts/switch.sh`

## CI

GitHub Actions (`nix/.github/workflows/check.yml`) runs `nix eval` on all 3 configs on push/PR to main.

<!-- BEGIN BEADS INTEGRATION v:1 profile:minimal hash:cdcea925 -->
## Beads Issue Tracker

This project uses **bd (beads)** for issue tracking. Run `bd prime` to see full workflow context and commands.

### Quick Reference

```bash
bd ready              # Find available work
bd show <id>          # View issue details
bd update <id> --claim  # Claim work
bd close <id>         # Complete work
```

### Rules

- Use `bd` for ALL task tracking — do NOT use TodoWrite, TaskCreate, or markdown TODO lists
- Run `bd prime` for detailed command reference and session close protocol
- Use `bd remember` for durable project facts — not per-tool memory files, which fragment across accounts; keep per-operator preferences in your harness's own memory

**Architecture in one line:** issues live in a local Dolt DB; sync uses `refs/dolt/data` on your git remote; `.beads/issues.jsonl` is a passive export. See https://github.com/gastownhall/beads/blob/main/docs/core-concepts/sync-concepts.md for details and anti-patterns.

## Agent Context Profiles

The managed Beads block is task-tracking guidance, not permission to override repository, user, or orchestrator instructions.

- **Conservative (default)**: Use `bd` for task tracking. Do not run git commits, git pushes, or Dolt remote sync unless explicitly asked. At handoff, report changed files, validation, and suggested next commands.
- **Minimal**: Keep tool instruction files as pointers to `bd prime`; use the same conservative git policy unless active instructions say otherwise.
- **Team-maintainer**: Only when the repository explicitly opts in, agents may close beads, run quality gates, commit, and push as part of session close. A current "do not commit" or "do not push" instruction still wins.

## Session Completion

This protocol applies when ending a Beads implementation workflow. It is subordinate to explicit user, repository, and orchestrator instructions.

1. **File issues for remaining work** - Create beads for anything that needs follow-up
2. **Run quality gates** (if code changed) - Tests, linters, builds
3. **Update issue status** - Close finished work, update in-progress items
4. **Handle git/sync by active profile**:
   ```bash
   # Conservative/minimal/default: report status and proposed commands; wait for approval.
   git status

   # Team-maintainer opt-in only, unless current instructions forbid it:
   git pull --rebase
   git push
   git status
   ```
5. **Hand off** - Summarize changes, validation, issue status, and any blocked sync/commit/push step

**Critical rules:**
- Explicit user or orchestrator instructions override this Beads block.
- Do not commit or push without clear authority from the active profile or the current user request.
- If a required sync or push is blocked, stop and report the exact command and error.
<!-- END BEADS INTEGRATION -->
