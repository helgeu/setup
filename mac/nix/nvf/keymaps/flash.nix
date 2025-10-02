# Flash.nvim Keymaps
# LazyVim keymaps for flash.nvim - 6 keymaps

[
  {
    mode = ["c"];
    key = "<c-s>";
    action = "<cmd>lua require('flash').toggle()<cr>";
    desc = "Toggle Flash Search";
  }
  {
    mode = ["o"];
    key = "r";
    action = "<cmd>lua require('flash').remote()<cr>";
    desc = "Remote Flash";
  }
  {
    mode = ["o" "x"];
    key = "R";
    action = "<cmd>lua require('flash').treesitter_search()<cr>";
    desc = "Treesitter Search";
  }
  {
    mode = ["n" "o" "x"];
    key = "s";
    action = "<cmd>lua require('flash').jump()<cr>";
    desc = "Flash";
  }
  {
    mode = ["n" "o" "x"];
    key = "S";
    action = "<cmd>lua require('flash').treesitter()<cr>";
    desc = "Flash Treesitter";
  }
  {
    mode = ["n" "o" "x"];
    key = "<c-space>";
    action = "<cmd>lua require('flash').treesitter()<cr>";
    desc = "Treesitter Incremental Selection";
  }
]