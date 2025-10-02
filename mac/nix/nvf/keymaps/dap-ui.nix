# nvim-dap-ui Keymaps
# LazyVim keymaps for nvim-dap-ui - 2 keymaps

[
  {
    mode = ["n" "v"];
    key = "<leader>de";
    action = "<cmd>lua require('dapui').eval()<cr>";
    desc = "Eval";
  }
  {
    mode = ["n"];
    key = "<leader>du";
    action = "<cmd>lua require('dapui').toggle()<cr>";
    desc = "Dap UI";
  }
]