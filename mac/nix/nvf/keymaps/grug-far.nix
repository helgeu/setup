# Grug-far.nvim Keymaps
# LazyVim keymaps for grug-far.nvim - 1 keymap

[
  {
    mode = ["n" "v"];
    key = "<leader>sr";
    action = "<cmd>lua require('grug-far').open({ transient = true })<cr>";
    desc = "Search and Replace";
  }
]