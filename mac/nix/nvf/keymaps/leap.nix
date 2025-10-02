# Leap.nvim Keymaps
# LazyVim keymaps for leap.nvim - 3 keymaps

[
  {
    mode = ["n" "o" "x"];
    key = "gs";
    action = "<cmd>lua require('leap.remote').action()<cr>";
    desc = "Leap from Windows";
  }
  {
    mode = ["n" "o" "x"];
    key = "s";
    action = "<cmd>lua require('leap').leap { target_windows = { vim.fn.win_getid() } }<cr>";
    desc = "Leap Forward to";
  }
  {
    mode = ["n" "o" "x"];
    key = "S";
    action = "<cmd>lua require('leap').leap { target_windows = { vim.fn.win_getid() }, backward = true }<cr>";
    desc = "Leap Backward to";
  }
]