# Conform.nvim Keymaps  
# LazyVim keymaps for conform.nvim - 1 keymap

[
  {
    mode = ["n" "v"];
    key = "<leader>cF";
    action = "<cmd>lua require('conform').format({ formatters = { 'injected' }, timeout_ms = 3000 })<cr>";
    desc = "Format Injected Langs";
  }
]