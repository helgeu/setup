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

scripts/                 # All scripts
  install.sh             # Bootstrap: install Nix + nix-darwin
  switch.sh              # Rebuild current machine
  update.sh              # Update flake inputs
  uninstall-nix.sh       # Complete Nix removal
  clean-homebrew.sh      # Pre-nix Homebrew cleanup
  discover-installed.sh  # Discover installed apps
  install-wsl-nixos.ps1  # Windows: WSL NixOS installer
  setup-nixos.sh         # WSL: post-install setup
```

## Conventions

- **DRY** - Shared config in `*/shared.nix`, machine-specific only where needed
- **Prefer `programs.X` modules** over `home.packages` when available
- **File naming** - Hostname for machine-specific, `shared.nix` for common
- **ALWAYS verify packages** - Before adding any package to nix config, verify it exists:
  ```bash
  nix eval nixpkgs#<package-name>.meta.description
  ```

## Commands

```bash
# Fresh install (new machine)
./scripts/install.sh

# Rebuild after config changes
sudo ./scripts/switch.sh

# Update flake inputs
./scripts/update.sh

# Complete Nix removal
./scripts/uninstall-nix.sh
```

Do NOT run `darwin-rebuild` directly - use `switch.sh`.

## Special Cases

### Brave Browser
Installed via **Homebrew** (not Nix) to preserve Apple code signature for iCloud Passwords compatibility. Extensions managed via:
- `ExtensionSettings` policy in `system.defaults.CustomUserPreferences`
- External Extensions JSON via `home.file`

### WSL Support (Planned)
PowerShell script `install-wsl-nixos.ps1` for Windows machines. Run from elevated PowerShell to install WSL2 + NixOS-WSL.
