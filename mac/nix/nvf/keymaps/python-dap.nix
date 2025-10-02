# Python DAP Language Support Keymaps
# Part of lazyvim.plugins.extras.lang.python
[
  # nvim-dap-python keymaps
  {
    key = "<leader>dPc";
    action = "<cmd>lua require('dap-python').test_class()<cr>";
    mode = ["n"];
    options = {
      desc = "Debug Class";
    };
  }
  {
    key = "<leader>dPt";
    action = "<cmd>lua require('dap-python').test_method()<cr>";
    mode = ["n"];
    options = {
      desc = "Debug Method";
    };
  }
]