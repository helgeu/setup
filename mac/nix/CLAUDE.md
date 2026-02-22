# Nix Darwin + Home Manager + NixOS-WSL

Multi-platform Nix configuration for macOS and WSL.

## Rules

- **Never suggest manual work** - Automate everything. Create scripts, write code, handle it directly. Exception: sudo commands (password required).

## Structure

- `system/*.nix` - System-level configs (nix-darwin on macOS, NixOS on WSL)
- `home-manager/*.nix` - Home-manager configs
- `dock/*.nix` - macOS Dock configs
- `scripts/` - Install/rebuild scripts
- `*/shared.nix` - Cross-platform shared config
- Hostname files for machine-specific config

## Conventions

- **DRY** - Shared config in `*/shared.nix`, machine-specific only where needed
- **Prefer `programs.X` modules** over `home.packages` when available
- **Cross-platform** - Use `pkgs.stdenv.isDarwin` / `isLinux` for conditionals
- **ALWAYS verify packages** before adding:
  ```bash
  nix eval nixpkgs#<package-name>.meta.description
  ```

## Validation Scripts

Always run these before committing or rebuilding:

```bash
./scripts/check.sh   # Syntax check all .nix files
./scripts/eval.sh    # Evaluate flake (catches runtime errors)
```

## Rebuild Commands

- macOS: `sudo ./scripts/switch.sh`
- WSL: `sudo nixos-rebuild switch --flake .#wsl-work`

Do NOT run `darwin-rebuild` directly.

## Special Cases

- **Brave Browser**: Installed via Homebrew (not Nix) for iCloud Passwords compatibility
- **Ghostty**: Installed via Homebrew (not Nix) - nixpkgs only supports Linux
- **macOS-only packages**: `xcodegen`, `alt-tab-macos`, `iterm2`, `ghostty`
- **Config paths**: macOS uses `Library/Application Support/`, Linux uses `.config/`
