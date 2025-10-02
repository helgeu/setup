# Project Utility Keymaps
# Part of lazyvim.plugins.extras.util.project
[
  # fzf-lua keymaps for project management
  {
    key = "<leader>fp";
    action = "<cmd>lua require('fzf-lua').files({ cwd = require('project_nvim').get_project_root() })<cr>";
    mode = ["n"];
    options = {
      desc = "Projects";
    };
  }
  # telescope.nvim keymaps for project management
  {
    key = "<leader>fp";
    action = "<cmd>Telescope projects<cr>";
    mode = ["n"];
    options = {
      desc = "Projects";
    };
  }
]