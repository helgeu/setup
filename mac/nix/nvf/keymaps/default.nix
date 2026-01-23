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
  #yanky = import ./yanky.nix;
  dap-core = import ./dap-core.nix;
  dap-ui = import ./dap-ui.nix;
  aerial = import ./aerial.nix;
  telescope-extra = import ./telescope-extra.nix;
  dial = import ./dial.nix;
  vim-illuminate = import ./vim-illuminate.nix;
  leap = import ./leap.nix;
  mini-surround-extra = import ./mini-surround-extra.nix;
  mini-diff = import ./mini-diff.nix;
  mini-files = import ./mini-files.nix;
  outline = import ./outline.nix;
  overseer = import ./overseer.nix;
  refactoring = import ./refactoring.nix;
  ansible = import ./ansible.nix;
  markdown = import ./markdown.nix;
  python-dap = import ./python-dap.nix;
  python-venv = import ./python-venv.nix;
  sql = import ./sql.nix;
  tex = import ./tex.nix;
  snacks-explorer = import ./snacks-explorer.nix;
  snacks-picker = import ./snacks-picker.nix;
  todo-comments-snacks = import ./todo-comments-snacks.nix;
  neotest = import ./neotest.nix;
  neotest-dap = import ./neotest-dap.nix;
  edgy = import ./edgy.nix;
  chezmoi = import ./chezmoi.nix;
  gitui = import ./gitui.nix;
  octo = import ./octo.nix;
  project = import ./project.nix;
  kulala = import ./kulala.nix;
  adoboards = import ./adoboards.nix;
in
  # Concatenate all keymaps - Systematically implementing ALL LazyVim sections
  general
  ++ lsp
  ++ bufferline
  ++ mason
  ++ conform
  ++ flash
  ++ grug-far
  ++ noice
  ++ persistence
  ++ snacks
  ++ todo-comments
  ++ trouble
  ++ which-key
  ++ copilot-chat
  ++ sidekick
  ++ mini-surround
  ++ neogen
  #++ yanky
  ++ dap-core
  ++ dap-ui
  ++ aerial
  ++ telescope-extra
  ++ dial
  ++ vim-illuminate
  ++ leap
  ++ mini-surround-extra
  ++ mini-diff
  ++ mini-files
  ++ outline
  ++ overseer
  ++ refactoring
  ++ ansible
  ++ markdown
  ++ python-dap
  ++ python-venv
  ++ sql
  ++ tex
  ++ snacks-explorer
  ++ snacks-picker
  ++ todo-comments-snacks
  ++ neotest
  ++ neotest-dap
  ++ edgy
  ++ chezmoi
  ++ gitui
  ++ octo
  ++ project
  ++ kulala  ++ adoboards