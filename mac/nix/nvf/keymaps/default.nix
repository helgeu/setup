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
  which-key = import ./which-key.nix;
  copilot-chat = import ./copilot-chat.nix;
  sidekick = import ./sidekick.nix;
  mini-surround = import ./mini-surround.nix;
  neogen = import ./neogen.nix;
in
# Concatenate all keymaps - Expanding LazyVim keymap implementation
  general ++ lsp ++ bufferline ++ mason ++ conform ++ flash ++ grug-far ++ noice ++ persistence ++ snacks ++ todo-comments ++ trouble ++ which-key ++ copilot-chat ++ sidekick ++ mini-surround ++ neogen