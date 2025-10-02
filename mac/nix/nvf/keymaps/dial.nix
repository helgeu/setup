# Dial.nvim Keymaps
# LazyVim keymaps for dial.nvim - 4 keymaps

[
  {
    mode = ["n" "v"];
    key = "<C-a>";
    action = "<cmd>lua require('dial.map').manipulate('increment', 'normal')<cr>";
    desc = "Increment";
  }
  {
    mode = ["n" "v"];
    key = "<C-x>";
    action = "<cmd>lua require('dial.map').manipulate('decrement', 'normal')<cr>";
    desc = "Decrement";
  }
  {
    mode = ["n" "v"];
    key = "g<C-a>";
    action = "<cmd>lua require('dial.map').manipulate('increment', 'gnormal')<cr>";
    desc = "Increment";
  }
  {
    mode = ["n" "v"];
    key = "g<C-x>";
    action = "<cmd>lua require('dial.map').manipulate('decrement', 'gnormal')<cr>";
    desc = "Decrement";
  }
]