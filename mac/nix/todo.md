# TODO for nix setup

## Priority

- [ ] Add helgeu@Helges-Macbook-Pro setup
  - [x] Create discovery script (scripts/discover-installed.sh)
  - [ ] Run discovery on home Mac, save results
  - [ ] Compare work vs home, decide on shared/separate modules
  - [ ] Build multi-machine flake structure
  - [ ] Clean home Mac before applying nix config

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
