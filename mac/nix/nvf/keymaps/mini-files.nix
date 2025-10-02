# Mini.files Keymaps
# LazyVim keymaps for mini.files - 2 keymaps

[
  {
    mode = ["n"];
    key = "<leader>fm";
    action = "<cmd>lua require('mini.files').open(vim.api.nvim_buf_get_name(0), true)<cr>";
    desc = "Open mini.files (Directory of Current File)";
  }
  {
    mode = ["n"];
    key = "<leader>fM";
    action = "<cmd>lua require('mini.files').open(vim.uv.cwd(), true)<cr>";
    desc = "Open mini.files (cwd)";
  }
]