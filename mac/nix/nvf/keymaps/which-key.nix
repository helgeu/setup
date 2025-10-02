# Which-key.nvim Keymaps
# LazyVim keymaps for which-key.nvim - 2 keymaps

[
  {
    mode = ["n"];
    key = "<c-w><space>";
    action = "<cmd>lua require('which-key').show('<c-w>', { mode = 'n', auto = true })<cr>";
    desc = "Window Hydra Mode (which-key)";
  }
  {
    mode = ["n"];
    key = "<leader>?";
    action = "<cmd>lua require('which-key').show({ global = false })<cr>";
    desc = "Buffer Keymaps (which-key)";
  }
]