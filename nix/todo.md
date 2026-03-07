# TODO for nix setup

## Priority

- [x] Add helgeu@Helges-MacBook-Pro setup
  - [x] Create discovery script (scripts/discover-installed.sh)
  - [x] Run discovery on home Mac, save results
  - [x] Compare work vs home, decide on shared/separate modules
  - [x] Build multi-machine flake structure
  - [x] Create cleanup script (scripts/clean-homebrew.sh)
  - [x] Create install script (scripts/install.sh)
  - [x] Fix install script (use official Nix installer, not Determinate)
  - [x] Run cleanup on home Mac
  - [x] Run install on home Mac

## Backlog

- [x] WSL NixOS setup
  - [x] Create PowerShell bootstrap script (scripts/install-wsl-nixos.ps1)
  - [x] Create post-install script (scripts/setup-nixos.sh)
  - [x] Refactor configs for cross-platform (git.nix, zsh.nix, vscode.nix)
  - [x] Add nixos-wsl input to flake.nix
  - [x] Create system/wsl-work.nix and home-manager/wsl-work.nix
  - [x] Add .gitattributes for cross-platform line endings
  - [x] Auto-enable Windows features (WSL, VirtualMachinePlatform)
  - [x] Use flake directly from Windows mount (/mnt/c/...)
  - [x] Complete first successful nixos-rebuild on Windows
- [ ] Window/tab/buffer titling (needs clarification)
  - [x] oh-my-posh console_title_template
  - [ ] nvim active file in terminal title?
  - [ ] bufferline/tabline in nvim?
- [ ] NVIM cleanup project
  - [x] Delete unused nixvim config (only NVF is used)
  - [x] Consolidate keymaps (50 files → 8 logical groups)
  - [x] Remove placeholder keymaps that just print "not implemented"
  - [x] Fix key conflicts (<leader>cs, <leader>fp, <leader>gS)
  - [x] Remove dead keymaps for uninstalled plugins (~107 keymaps, 230 lines)
  - [ ] blink-cmp AI completion
    - [blink-cmp-copilot](https://github.com/giuxtaposition/blink-cmp-copilot)
    - [copilot.lua](https://github.com/zbirenbaum/copilot.lua) (prerequisite)
- [ ] NVIM project & session management (LazyVim-style)
  - [ ] Investigate project management options: Snacks.project, project.nvim, workspaces.nvim
  - [ ] Research how LazyVim handles project switching and session restore
  - [ ] Add persistence.nvim (currently referenced in keymaps but not installed)
  - [ ] Configure project select workflow:
    - Don't auto-open file picker on project select
    - Open explorer instead
    - Auto-restore session (open files, buffers) if exists
  - [ ] Auto-save session on exit when in a project
  - [ ] Restore explorer state with session
- [ ] Yabai, aerospace, amethyst? (tiling WM)
  - (Example for aerospace)[https://github.com/AlexNabokikh/nix-config/blob/master/modules/home-manager/programs/aerospace/default.nix]
- [ ] Dock folder icons (custom icons via fileicon)

## Suggestions

- [ ] Touch ID + Apple Watch sudo authentication
  - `security.pam.enableSudoTouchIdAuth = true` in system/shared.nix
  - Enables Touch ID and Apple Watch for sudo on both Macs
  - Note: Apple Watch screen unlock is System Settings only (iCloud pairing)

## Done

- [x] Nix config refactoring (Feb 2026)
  - Deleted unused nixvim config (18 files, ~900 lines)
  - Renamed home/ to home-manager/ for clarity
  - Created shared modules (macos-shared.nix, work-tools.nix, dock/shared.nix)
  - Removed Brave External Extensions (keep system policy only)
  - Cleaned up unused bindings across all files
  - Added validation scripts (check.sh, eval.sh, build.sh)
- [x] NVF keymap consolidation (Feb 2026)
  - Consolidated 50 keymap files → 8 logical groups
  - Removed 16 placeholder keymaps ("not implemented")
  - Fixed key conflicts (cs→trouble/cA→aerial/cO→outline, gS→gO for octo)
  - Deleted duplicate files (snacks-picker, todo-comments, project)
- [x] Terminal & nvim improvements (Feb 2026)
  - Added Ghostty terminal (via Homebrew) with Dracula theme, synced with iTerm2 config
  - Enabled trouble.nvim, removed aerial (use trouble for symbols)
  - Removed adoboards-tui (nvim plugin, package, flake input)
  - Added nvim-check.sh for headless diagnostics
  - Added packages: tree-sitter, imagemagick, mermaid-cli
  - Improved update.sh with validation
  - Fixed Snacks dashboard (removed lazy.nvim dependency)
  - Configured Snacks.image for inline rendering in Ghostty (autocmd on markdown)
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
