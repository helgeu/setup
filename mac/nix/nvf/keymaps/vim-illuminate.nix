# Vim-illuminate Keymaps
# LazyVim keymaps for vim-illuminate - 2 keymaps

[
  {
    mode = ["n"];
    key = "[[";
    action = "<cmd>lua require('illuminate').goto_prev_reference(false)<cr>";
    desc = "Prev Reference";
  }
  {
    mode = ["n"];
    key = "]]";
    action = "<cmd>lua require('illuminate').goto_next_reference(false)<cr>";
    desc = "Next Reference";
  }
]