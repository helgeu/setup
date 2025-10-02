# Default keymaps aggregator - collects all keymap sections
let 
  # Import General section only for now
  general = import ./general.nix;
in
# Return general keymaps
  general