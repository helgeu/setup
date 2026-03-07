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

Convention: `*/shared.nix` holds cross-machine config; hostname files hold machine-specific overrides. Use `pkgs.stdenv.isDarwin`/`isLinux` for platform conditionals.

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
