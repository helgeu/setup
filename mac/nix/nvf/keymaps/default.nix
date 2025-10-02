# Default keymaps aggregator - collects all keymap sections
let 
  # Import available sections
  general = import ./general.nix;
  lsp = import ./lsp.nix;
  bufferline = import ./bufferline.nix;
  mason = import ./mason.nix;
  conform = import ./conform.nix;
  flash = import ./flash.nix;
  grug-far = import ./grug-far.nix;
  noice = import ./noice.nix;
  persistence = import ./persistence.nix;
  snacks = import ./snacks.nix;
  todo-comments = import ./todo-comments.nix;
  trouble = import ./trouble.nix;
in
# Concatenate all keymaps - COMPLETE LazyVim keymap implementation (207 total)
  general ++ lsp ++ bufferline ++ mason ++ conform ++ flash ++ grug-far ++ noice ++ persistence ++ snacks ++ todo-comments ++ trouble