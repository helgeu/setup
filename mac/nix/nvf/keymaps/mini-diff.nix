# Mini.diff Keymaps
# LazyVim keymaps for mini.diff - 1 keymap

[
  {
    mode = ["n"];
    key = "<leader>go";
    action = "<cmd>lua require('mini.diff').toggle_overlay()<cr>";
    desc = "Toggle mini.diff overlay";
  }
]