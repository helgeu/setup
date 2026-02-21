# Nix Darwin + Home Manager Configuration

macOS system configuration using nix-darwin and home-manager.

## Structure

- `flake.nix` - Main flake with inputs and outputs
- `configuration.nix` - System-level config (nix-darwin)
- `work.nix` - User-level config (home-manager), imports other modules
- `git.nix`, `zsh.nix`, etc. - Modular home-manager configs
- `nvf/` - Neovim configuration via nvf

## Conventions

- **Prefer `programs.X` modules** over adding packages to `home.packages` when a home-manager module exists (provides declarative configuration)
- **Check documentation** before adding new packages to find the best integration approach
- **Keep version branches aligned** - nixpkgs, nix-darwin, and home-manager should use matching release branches (e.g., all `25.11` or all `release-25.11`)
- **User packages in `work.nix`**, system packages in `configuration.nix`
- **Keep git-credential-manager** for git authentication (supports both GitHub and Azure DevOps)

## Rebuild

```bash
sudo ./switch.sh
```

Do NOT run `darwin-rebuild` directly.
