# Windows Setup

Manual Windows setup scripts (not managed by Nix).

## Usage

From an elevated PowerShell:

```powershell
.\install.ps1                    # Install apps via winget
.\install-vscode-extensions.ps1  # Install VS Code extensions
```

## Notes

- Requires [winget](https://github.com/microsoft/winget-cli)
- For WSL/NixOS setup, see `../nix/scripts/install-wsl-nixos.ps1`
