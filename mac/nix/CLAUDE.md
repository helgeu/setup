# Nix Darwin + Home Manager Configuration

macOS system configuration using nix-darwin and home-manager.

## Structure

```
flake.nix                # Multi-machine flake

system/                  # nix-darwin configs
  shared.nix
  NO-GLV6Y9N492.nix      # Work Mac
  Helges-MacBook-Pro.nix # Personal Mac

home/                    # home-manager configs
  shared.nix
  NO-GLV6Y9N492.nix
  Helges-MacBook-Pro.nix

dock/                    # Dock configurations
  NO-GLV6Y9N492.nix
  Helges-MacBook-Pro.nix
```

## Conventions

- **DRY** - Shared config in `*/shared.nix`, machine-specific only where needed
- **Prefer `programs.X` modules** over `home.packages` when available
- **File naming** - Hostname for machine-specific, `shared.nix` for common
- **ALWAYS verify packages** - Before adding any package to nix config, verify it exists:
  ```bash
  nix eval nixpkgs#<package-name>.meta.description
  ```

## Rebuild

```bash
sudo ./switch.sh
```

Do NOT run `darwin-rebuild` directly.
