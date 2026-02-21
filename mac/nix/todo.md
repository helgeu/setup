# TODO for nix setup

## Priority

- [ ] Add helgeu@Helges-MacBook-Pro setup
  - [x] Create discovery script (scripts/discover-installed.sh)
  - [x] Run discovery on home Mac, save results
  - [x] Compare work vs home, decide on shared/separate modules
  - [x] Build multi-machine flake structure
  - [x] Create cleanup script (scripts/clean-homebrew.sh)
  - [x] Create install script (scripts/install.sh)
  - [x] Fix install script (use official Nix installer, not Determinate)
  - [x] Run cleanup on home Mac
  - [ ] Run install on home Mac

## Backlog

- [ ] WSL NixOS setup
  - [x] Create PowerShell bootstrap script (scripts/install-wsl-nixos.ps1)
  - [x] Create post-install script (scripts/setup-nixos.sh)
  - [x] Refactor configs for cross-platform (git.nix, zsh.nix, vscode.nix)
  - [x] Add nixos-wsl input to flake.nix
  - [x] Create system/wsl-work.nix and home/wsl-work.nix
  - [ ] Test on Windows machine
- [ ] Window/tab/buffer titling (needs clarification)
  - [x] oh-my-posh console_title_template
  - [ ] nvim active file in terminal title?
  - [ ] bufferline/tabline in nvim?
- [ ] NVIM cleanup project
  - Clean up entire nvim setup, remove unused plugins/config
  - Simplify and reorganize keybindings
  - Too cluttered as-is
  - [ ] blink-cmp AI completion
    - (blink-cmp and blink-cmp-copilot)[https://github.com/giuxtaposition/blink-cmp-copilot]
    - copilot.lua (prerequisites)[https://github.com/zbirenbaum/copilot.lua]
- [ ] Yabai, aerospace, amethyst? (tiling WM)
  - (Example for aerospace)[https://github.com/AlexNabokikh/nix-config/blob/master/modules/home-manager/programs/aerospace/default.nix]
- [ ] Dock folder icons (custom icons via fileicon)

## Done

- [x] macOS Dock configuration
  - Research, create dock configs, integrate into flake
- [x] Make Brave default browser (via duti)
- [x] Brave migration to Homebrew (for iCloud Passwords compatibility)
  - Nix strips Apple code signatures, breaking iCloud Passwords whitelist
  - Now installed via Homebrew cask, policies via CustomUserPreferences
- [x] Declarative Brave extension management
  - ExtensionSettings policy + External Extensions JSON
  - Vimium, iCloud Passwords auto-install
- [x] AI dev (VS Code)
- [x] Swift dev
- [x] Script consolidation
  - All scripts moved to scripts/
  - Created uninstall-nix.sh (combined undo-bootstrap scripts)
  - Removed obsolete bootstrap-nix*.sh
