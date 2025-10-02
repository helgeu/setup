# GitUi Utility Keymaps
# Part of lazyvim.plugins.extras.util.gitui
[
  # mason.nvim keymaps for GitUi integration
  {
    key = "<leader>gg";
    action = "<cmd>lua Snacks.gitbrowse()<cr>";
    mode = ["n"];
    desc = "GitUi (Root Dir)";
  }
  {
    key = "<leader>gG";
    action = "<cmd>lua Snacks.gitbrowse({ cwd = vim.uv.cwd() })<cr>";
    mode = ["n"];
    desc = "GitUi (cwd)";
  }
]