# Persistence.nvim Keymaps
# LazyVim keymaps for persistence.nvim - 4 keymaps

[
  {
    mode = ["n"];
    key = "<leader>qd";
    action = "<cmd>lua require('persistence').stop()<cr>";
    desc = "Don't Save Current Session";
  }
  {
    mode = ["n"];
    key = "<leader>ql";
    action = "<cmd>lua require('persistence').load({ last = true })<cr>";
    desc = "Restore Last Session";
  }
  {
    mode = ["n"];
    key = "<leader>qs";
    action = "<cmd>lua require('persistence').load()<cr>";
    desc = "Restore Session";
  }
  {
    mode = ["n"];
    key = "<leader>qS";
    action = "<cmd>lua require('persistence').select()<cr>";
    desc = "Select Session";
  }
]