# Snacks Explorer Keymaps
# Part of lazyvim.plugins.extras.editor.snacks_explorer
[
  # snacks.nvim explorer keymaps
  {
    key = "<leader>e";
    action = "<cmd>lua Snacks.explorer.open({ cwd = vim.uv.cwd() })<cr>";
    mode = ["n"];
    desc = "Explorer Snacks (root dir)";
  }
  {
    key = "<leader>E";
    action = "<cmd>lua Snacks.explorer.open()<cr>";
    mode = ["n"];
    desc = "Explorer Snacks (cwd)";
  }
  {
    key = "<leader>fe";
    action = "<cmd>lua Snacks.explorer.open({ cwd = vim.uv.cwd() })<cr>";
    mode = ["n"];
    desc = "Explorer Snacks (root dir)";
  }
  {
    key = "<leader>fE";
    action = "<cmd>lua Snacks.explorer.open()<cr>";
    mode = ["n"];
    desc = "Explorer Snacks (cwd)";
  }
]