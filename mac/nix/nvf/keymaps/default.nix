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
  yanky = import ./yanky.nix;
  dap-core = import ./dap-core.nix;
  dap-ui = import ./dap-ui.nix;
  aerial = import ./aerial.nix;
  telescope-extra = import ./telescope-extra.nix;
  dial = import ./dial.nix;
  harpoon = import ./harpoon.nix;
  vim-illuminate = import ./vim-illuminate.nix;
  leap = import ./leap.nix;
  mini-surround-extra = import ./mini-surround-extra.nix;
  mini-diff = import ./mini-diff.nix;
  mini-files = import ./mini-files.nix;
  outline = import ./outline.nix;
  overseer = import ./overseer.nix;
  refactoring = import ./refactoring.nix;
in
# Concatenate all keymaps - Systematically implementing ALL LazyVim sections
  general ++ lsp ++ bufferline ++ mason ++ conform ++ flash ++ grug-far ++ noice ++ persistence ++ snacks ++ todo-comments ++ trouble ++ which-key ++ copilot-chat ++ sidekick ++ mini-surround ++ neogen ++ yanky ++ dap-core ++ dap-ui ++ aerial ++ telescope-extra ++ dial ++ harpoon ++ vim-illuminate ++ leap ++ mini-surround-extra ++ mini-diff ++ mini-files ++ outline ++ overseer ++ refactoring