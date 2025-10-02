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
in
# Concatenate all keymaps
  general ++ lsp ++ bufferline ++ mason ++ conform ++ flash ++ grug-far