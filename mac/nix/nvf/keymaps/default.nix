# Default keymaps aggregator - collects all keymap sections
let 
  # Import available sections
  general = import ./general.nix;
  lsp = import ./lsp.nix;
  bufferline = import ./bufferline.nix;
in
# Concatenate all keymaps
  general ++ lsp ++ bufferline