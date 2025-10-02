# Neotest DAP Integration Keymaps
# Part of lazyvim.plugins.extras.test.core
[
  # nvim-dap keymap for neotest integration
  {
    key = "<leader>td";
    action = "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>";
    mode = ["n"];
    desc = "Debug Nearest";
  }
]