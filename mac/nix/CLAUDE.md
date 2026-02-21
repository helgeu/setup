# Nix Configuration (macOS + WSL)

Multi-platform system configuration using nix-darwin (macOS) and NixOS-WSL (Windows).

## Structure

```
flake.nix                # Multi-machine flake

system/                  # System configs
  shared.nix             # macOS shared
  NO-GLV6Y9N492.nix      # Work Mac
  Helges-MacBook-Pro.nix # Personal Mac
  wsl-work.nix           # WSL NixOS

home/                    # home-manager configs
  shared.nix             # Cross-platform shared
  NO-GLV6Y9N492.nix
  Helges-MacBook-Pro.nix
  wsl-work.nix           # WSL home config

dock/                    # macOS Dock configurations
  NO-GLV6Y9N492.nix
  Helges-MacBook-Pro.nix

scripts/                 # All scripts
  install.sh             # macOS: install Nix + nix-darwin
  switch.sh              # macOS: rebuild current machine
  update.sh              # Update flake inputs
  uninstall-nix.sh       # macOS: complete Nix removal
  clean-homebrew.sh      # macOS: pre-nix Homebrew cleanup
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

### WSL NixOS (Windows)

**Fresh install on Windows:**

```powershell
# Run as Administrator in PowerShell
.\scripts\install-wsl-nixos.ps1
```

This will:
1. Enable/update WSL2
2. Download and import NixOS-WSL
3. Clone this repo inside WSL
4. Run initial setup

**After install (inside WSL):**

```bash
cd ~/git/setup/mac/nix
sudo nixos-rebuild switch --flake .#wsl-work
```

**Rebuild after config changes:**

```bash
sudo nixos-rebuild switch --flake ~/git/setup/mac/nix#wsl-work
```

**Configuration:**
- System config: `system/wsl-work.nix`
- Home config: `home/wsl-work.nix`
- User: `helge`
- Hostname: `wsl-work`
