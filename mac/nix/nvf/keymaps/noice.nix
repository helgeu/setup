# Noice.nvim Keymaps
# LazyVim keymaps for noice.nvim - 9 keymaps

[
  {
    mode = ["n" "i" "s"];
    key = "<c-b>";
    action = "<cmd>lua if not require('noice.lsp').scroll(-4) then return '<c-b>' end<cr>";
    desc = "Scroll Backward";
    expr = true;
  }
  {
    mode = ["n" "i" "s"];
    key = "<c-f>";
    action = "<cmd>lua if not require('noice.lsp').scroll(4) then return '<c-f>' end<cr>";
    desc = "Scroll Forward";
    expr = true;
  }
  {
    mode = ["n"];
    key = "<leader>sn";
    action = "";
    desc = "+noice";
  }
  {
    mode = ["n"];
    key = "<leader>sna";
    action = "<cmd>NoiceAll<cr>";
    desc = "Noice All";
  }
  {
    mode = ["n"];
    key = "<leader>snd";
    action = "<cmd>NoiceDismiss<cr>";
    desc = "Dismiss All";
  }
  {
    mode = ["n"];
    key = "<leader>snh";
    action = "<cmd>NoiceHistory<cr>";
    desc = "Noice History";
  }
  {
    mode = ["n"];
    key = "<leader>snl";
    action = "<cmd>NoiceLast<cr>";
    desc = "Noice Last Message";
  }
  {
    mode = ["n"];
    key = "<leader>snt";
    action = "<cmd>NoiceTelescope<cr>";
    desc = "Noice Picker (Telescope/FzfLua)";
  }
  {
    mode = ["c"];
    key = "<S-Enter>";
    action = "<cmd>lua require('noice').redirect(vim.fn.getcmdline())<cr>";
    desc = "Redirect Cmdline";
  }
]