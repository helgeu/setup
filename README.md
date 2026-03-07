# setup

Personal machine setup for macOS, Windows, and WSL.

## Structure

```
nix/     # Nix configuration (macOS via nix-darwin, WSL via NixOS)
win/     # Windows setup scripts (winget + VS Code extensions)
```

## Quick Start

### macOS / WSL

See [`nix/readme.md`](nix/readme.md) for full instructions.

```bash
# macOS: fresh install
nix/scripts/install.sh

# macOS: rebuild
sudo nix/scripts/switch.sh

# WSL: install from Windows
.\nix\scripts\install-wsl-nixos.cmd
```

### Windows

```powershell
.\win\install.ps1
.\win\install-vscode-extensions.ps1
```
