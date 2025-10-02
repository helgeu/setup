# Mini.surround Keymaps
# LazyVim keymaps for mini.surround - 7 keymaps

[
  {
    mode = ["n" "v"];
    key = "gsa";
    action = "<cmd>lua require('mini.surround').add('visual')<cr>";
    desc = "Add Surrounding";
  }
  {
    mode = ["n"];
    key = "gsd";
    action = "<cmd>lua require('mini.surround').delete()<cr>";
    desc = "Delete Surrounding";
  }
  {
    mode = ["n"];
    key = "gsf";
    action = "<cmd>lua require('mini.surround').find_right()<cr>";
    desc = "Find Right Surrounding";
  }
  {
    mode = ["n"];
    key = "gsF";
    action = "<cmd>lua require('mini.surround').find_left()<cr>";
    desc = "Find Left Surrounding";
  }
  {
    mode = ["n"];
    key = "gsh";
    action = "<cmd>lua require('mini.surround').highlight()<cr>";
    desc = "Highlight Surrounding";
  }
  {
    mode = ["n"];
    key = "gsn";
    action = "<cmd>lua require('mini.surround').update_n_lines()<cr>";
    desc = "Update `MiniSurround.config.n_lines`";
  }
  {
    mode = ["n"];
    key = "gsr";
    action = "<cmd>lua require('mini.surround').replace()<cr>";
    desc = "Replace Surrounding";
  }
]