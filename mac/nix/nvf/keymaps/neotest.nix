# Neotest Testing Keymaps
# Part of lazyvim.plugins.extras.test.core
[
  # neotest keymaps
  {
    key = "<leader>t";
    action = "+test";
    mode = ["n"];
    options = {
      desc = "+test";
    };
  }
  {
    key = "<leader>tl";
    action = "<cmd>lua require('neotest').run.run_last()<cr>";
    mode = ["n"];
    options = {
      desc = "Run Last (Neotest)";
    };
  }
  {
    key = "<leader>to";
    action = "<cmd>lua require('neotest').output.open({ enter = true, auto_close = true })<cr>";
    mode = ["n"];
    options = {
      desc = "Show Output (Neotest)";
    };
  }
  {
    key = "<leader>tO";
    action = "<cmd>lua require('neotest').output_panel.toggle()<cr>";
    mode = ["n"];
    options = {
      desc = "Toggle Output Panel (Neotest)";
    };
  }
  {
    key = "<leader>tr";
    action = "<cmd>lua require('neotest').run.run()<cr>";
    mode = ["n"];
    options = {
      desc = "Run Nearest (Neotest)";
    };
  }
  {
    key = "<leader>ts";
    action = "<cmd>lua require('neotest').summary.toggle()<cr>";
    mode = ["n"];
    options = {
      desc = "Toggle Summary (Neotest)";
    };
  }
  {
    key = "<leader>tS";
    action = "<cmd>lua require('neotest').run.stop()<cr>";
    mode = ["n"];
    options = {
      desc = "Stop (Neotest)";
    };
  }
  {
    key = "<leader>tt";
    action = "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>";
    mode = ["n"];
    options = {
      desc = "Run File (Neotest)";
    };
  }
  {
    key = "<leader>tT";
    action = "<cmd>lua require('neotest').run.run(vim.uv.cwd())<cr>";
    mode = ["n"];
    options = {
      desc = "Run All Test Files (Neotest)";
    };
  }
  {
    key = "<leader>tw";
    action = "<cmd>lua require('neotest').watch.toggle(vim.fn.expand('%'))<cr>";
    mode = ["n"];
    options = {
      desc = "Toggle Watch (Neotest)";
    };
  }
]