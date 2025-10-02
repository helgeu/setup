# nvim-dap Keymaps
# LazyVim keymaps for nvim-dap - 17 keymaps

[
  {
    mode = ["n"];
    key = "<leader>da";
    action = "<cmd>lua require('dap').run_with_args(vim.fn.input('Args: '))<cr>";
    desc = "Run with Args";
  }
  {
    mode = ["n"];
    key = "<leader>db";
    action = "<cmd>lua require('dap').toggle_breakpoint()<cr>";
    desc = "Toggle Breakpoint";
  }
  {
    mode = ["n"];
    key = "<leader>dB";
    action = "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>";
    desc = "Breakpoint Condition";
  }
  {
    mode = ["n"];
    key = "<leader>dc";
    action = "<cmd>lua require('dap').continue()<cr>";
    desc = "Run/Continue";
  }
  {
    mode = ["n"];
    key = "<leader>dC";
    action = "<cmd>lua require('dap').run_to_cursor()<cr>";
    desc = "Run to Cursor";
  }
  {
    mode = ["n"];
    key = "<leader>dg";
    action = "<cmd>lua require('dap').goto_()<cr>";
    desc = "Go to Line (No Execute)";
  }
  {
    mode = ["n"];
    key = "<leader>di";
    action = "<cmd>lua require('dap').step_into()<cr>";
    desc = "Step Into";
  }
  {
    mode = ["n"];
    key = "<leader>dj";
    action = "<cmd>lua require('dap').down()<cr>";
    desc = "Down";
  }
  {
    mode = ["n"];
    key = "<leader>dk";
    action = "<cmd>lua require('dap').up()<cr>";
    desc = "Up";
  }
  {
    mode = ["n"];
    key = "<leader>dl";
    action = "<cmd>lua require('dap').run_last()<cr>";
    desc = "Run Last";
  }
  {
    mode = ["n"];
    key = "<leader>do";
    action = "<cmd>lua require('dap').step_out()<cr>";
    desc = "Step Out";
  }
  {
    mode = ["n"];
    key = "<leader>dO";
    action = "<cmd>lua require('dap').step_over()<cr>";
    desc = "Step Over";
  }
  {
    mode = ["n"];
    key = "<leader>dP";
    action = "<cmd>lua require('dap').pause()<cr>";
    desc = "Pause";
  }
  {
    mode = ["n"];
    key = "<leader>dr";
    action = "<cmd>lua require('dap').repl.toggle()<cr>";
    desc = "Toggle REPL";
  }
  {
    mode = ["n"];
    key = "<leader>ds";
    action = "<cmd>lua require('dap').session()<cr>";
    desc = "Session";
  }
  {
    mode = ["n"];
    key = "<leader>dt";
    action = "<cmd>lua require('dap').terminate()<cr>";
    desc = "Terminate";
  }
  {
    mode = ["n"];
    key = "<leader>dw";
    action = "<cmd>lua require('dap.ui.widgets').hover()<cr>";
    desc = "Widgets";
  }
]