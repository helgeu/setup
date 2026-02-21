# TODO for nix setup

## Priority

- [ ] macOS Dock configuration
  - [x] Research nix-darwin dock options
  - [x] Create work-dock.nix and home-dock.nix
  - [x] Integrated into flake.nix
  - [ ] Test on work Mac: `sudo ./switch.sh`
  - Known issue: Home Manager app paths may show ? icons (see mac-app-util)
- [ ] Add helgeu@Helges-MacBook-Pro setup
  - [x] Create discovery script (scripts/discover-installed.sh)
  - [x] Run discovery on home Mac, save results
  - [x] Compare work vs home, decide on shared/separate modules
  - [x] Build multi-machine flake structure
  - [ ] Clean home Mac (uninstall Homebrew packages)
  - [ ] Install Nix on home Mac
  - [ ] Clone repo and run switch

## Backlog

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

## Done

- [x] Make Brave default browser (via duti)
- [x] Brave and extensions
- [x] AI dev (VS Code)
- [x] Swift dev
