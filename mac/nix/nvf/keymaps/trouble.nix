# Trouble.nvim Keymaps
# LazyVim keymaps for trouble.nvim - 8 keymaps

[
  {
    mode = ["n"];
    key = "<leader>cs";
    action = "<cmd>Trouble symbols toggle<cr>";
    desc = "Symbols (Trouble)";
  }
  {
    mode = ["n"];
    key = "<leader>cS";
    action = "<cmd>Trouble lsp toggle<cr>";
    desc = "LSP references/definitions/... (Trouble)";
  }
  {
    mode = ["n"];
    key = "<leader>xL";
    action = "<cmd>Trouble loclist toggle<cr>";
    desc = "Location List (Trouble)";
  }
  {
    mode = ["n"];
    key = "<leader>xQ";
    action = "<cmd>Trouble qflist toggle<cr>";
    desc = "Quickfix List (Trouble)";
  }
  {
    mode = ["n"];
    key = "<leader>xx";
    action = "<cmd>Trouble diagnostics toggle<cr>";
    desc = "Diagnostics (Trouble)";
  }
  {
    mode = ["n"];
    key = "<leader>xX";
    action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>";
    desc = "Buffer Diagnostics (Trouble)";
  }
  {
    mode = ["n"];
    key = "[q";
    action = "<cmd>lua require('trouble').prev({ skip_groups = true, jump = true })<cr>";
    desc = "Previous Trouble/Quickfix Item";
  }
  {
    mode = ["n"];
    key = "]q";
    action = "<cmd>lua require('trouble').next({ skip_groups = true, jump = true })<cr>";
    desc = "Next Trouble/Quickfix Item";
  }
]