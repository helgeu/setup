# Default keymaps aggregator - consolidated into logical groups
# Only includes keymaps for INSTALLED plugins
let
  keymapModules = [
    "core"        # movement, windows, buffers, tabs, UI toggles
    "editor"      # (empty - add when installing editor plugins)
    "tools"       # LSP
    "git"         # Snacks git browse
    "debug-test"  # DAP, dap-ui
    "navigation"  # Snacks picker, Snacks explorer
    "ui"          # Trouble, which-key, noice, bufferline, edgy
  ];

  importModule = name: import ./${name}.nix;
in
  builtins.concatLists (map importModule keymapModules)
