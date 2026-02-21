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
  switch.sh              # macOS: rebuild
  update.sh              # Update flake inputs
  uninstall-nix.sh       # macOS: complete Nix removal
  clean-homebrew.sh      # macOS: pre-nix Homebrew cleanup
  discover-installed.sh  # Discover installed apps
  install-wsl-nixos.ps1  # Windows: WSL NixOS installer
  setup-nixos.sh         # WSL: post-install setup
```

## macOS

### Fresh Install

```bash
./scripts/install.sh
```

### Rebuild

```bash
sudo ./scripts/switch.sh
```

### Update Flake Inputs

```bash
./scripts/update.sh
```

### Uninstall

```bash
./scripts/uninstall-nix.sh
```

## Windows (WSL)

### Fresh Install

Right-click `scripts\install-wsl-nixos.cmd` → **Run as administrator**

Or from an elevated Command Prompt / PowerShell:

```cmd
.\scripts\install-wsl-nixos.cmd
```

This will:
1. Enable/update WSL2
2. Download and import NixOS-WSL
3. Clone this repo inside WSL
4. Run initial setup

### After Install (inside WSL)

```bash
cd ~/git/setup/mac/nix
sudo nixos-rebuild switch --flake .#wsl-work
```

### Rebuild

```bash
sudo nixos-rebuild switch --flake ~/git/setup/mac/nix#wsl-work
```

## Machines

| Name | Type | Config |
|------|------|--------|
| NO-GLV6Y9N492 | Work Mac | `darwinConfigurations."NO-GLV6Y9N492"` |
| Helges-MacBook-Pro | Personal Mac | `darwinConfigurations."Helges-MacBook-Pro"` |
| wsl-work | Windows WSL | `nixosConfigurations."wsl-work"` |

## Notes

### Brave Browser
Installed via Homebrew (not Nix) to preserve Apple code signature for iCloud Passwords. Extensions managed via enterprise policies.
