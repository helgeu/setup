# Mac Setup with Nix, nix-darwin and Home Manager

Declarative macOS configuration using nix-darwin and home-manager.

## Structure

```
.
├── flake.nix            # Main flake with inputs and outputs
├── configuration.nix    # System-level config (nix-darwin)
├── work.nix             # User-level config (home-manager), imports modules
├── git.nix              # Git configuration
├── zsh.nix              # Zsh shell configuration
├── iterm2.nix           # iTerm2 preferences
├── vscode.nix           # VS Code configuration
├── adoboards-config.nix # Azure DevOps TUI configuration
├── claude.nix           # Claude Code global rules
├── claude/              # Claude Code config files
├── nvf.nix              # Neovim configuration via nvf
├── nvf/                 # Neovim modules and keymaps
└── nixvim/              # Legacy nixvim config (unused)
```

## Bootstrap

### 1. Install Nix

```bash
./bootstrap-nix.sh
```

Or manually:

```bash
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install)
```

### 2. Install nix-darwin

```bash
./bootstrap-nix-darwin.sh
```

This runs the initial nix-darwin switch. After this, use `./switch.sh` for rebuilds.

## Daily Usage

### Rebuild after changes

```bash
./switch.sh
```

Or directly:

```bash
darwin-rebuild switch --flake .
```

### Update flake inputs

```bash
./update.sh
```

This updates all flake inputs and commits the lock file.

## Scripts

| Script | Purpose |
|--------|---------|
| `bootstrap-nix.sh` | Install Nix |
| `bootstrap-nix-darwin.sh` | Initial nix-darwin setup |
| `switch.sh` | Rebuild configuration |
| `update.sh` | Update flake inputs |
| `cleangitcred.sh` | Clean git credentials |
| `undo-bootstrap-1.sh` | Uninstall step 1 |
| `undo-bootstrap-2.sh` | Uninstall step 2 |

## Uninstall

See https://nix.dev/manual/nix/2.28/installation/uninstall#macos

1. Run `./undo-bootstrap-1.sh`
2. Edit fstab: `sudo vifs` and remove the Nix Store mount line
3. Edit `/etc/synthetic.conf` to remove the nix line
4. Run `./undo-bootstrap-2.sh`
