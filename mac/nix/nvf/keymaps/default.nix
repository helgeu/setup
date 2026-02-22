# Default keymaps aggregator - consolidated into 8 logical groups
let
  keymapModules = [
    "core"        # movement, windows, buffers, tabs, UI toggles
    "editor"      # refactoring, surround, increment/decrement, yank
    "tools"       # LSP, language-specific, utilities, sessions
    "git"         # git tools and GitHub integration
    "debug-test"  # DAP, neotest
    "navigation"  # pickers, file explorer, motion
    "ui"          # trouble, symbols, notifications, bufferline
  ];

  importModule = name: import ./${name}.nix;
in
  builtins.concatLists (map importModule keymapModules)
