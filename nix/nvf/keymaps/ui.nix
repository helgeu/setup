# UI keymaps - trouble, which-key, noice, bufferline, edgy
# Installed: trouble, which-key, noice, bufferline, edgy
# Removed: outline
[
  # === Trouble ===
  { mode = ["n"]; key = "<leader>cs"; action = "<cmd>Trouble symbols toggle<cr>"; desc = "Symbols (Trouble)"; }
  { mode = ["n"]; key = "<leader>cS"; action = "<cmd>Trouble lsp toggle<cr>"; desc = "LSP references/definitions/... (Trouble)"; }
  { mode = ["n"]; key = "<leader>xL"; action = "<cmd>Trouble loclist toggle<cr>"; desc = "Location List (Trouble)"; }
  { mode = ["n"]; key = "<leader>xQ"; action = "<cmd>Trouble qflist toggle<cr>"; desc = "Quickfix List (Trouble)"; }
  { mode = ["n"]; key = "<leader>xx"; action = "<cmd>Trouble diagnostics toggle<cr>"; desc = "Diagnostics (Trouble)"; }
  { mode = ["n"]; key = "<leader>xX"; action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>"; desc = "Buffer Diagnostics (Trouble)"; }
  { mode = ["n"]; key = "[q"; action = "<cmd>lua require('trouble').prev({ skip_groups = true, jump = true })<cr>"; desc = "Previous Trouble/Quickfix Item"; }
  { mode = ["n"]; key = "]q"; action = "<cmd>lua require('trouble').next({ skip_groups = true, jump = true })<cr>"; desc = "Next Trouble/Quickfix Item"; }

  # === Which-key ===
  { mode = ["n"]; key = "<c-w><space>"; action = "<cmd>lua require('which-key').show('<c-w>', { mode = 'n', auto = true })<cr>"; desc = "Window Hydra Mode (which-key)"; }
  { mode = ["n"]; key = "<leader>?"; action = "<cmd>lua require('which-key').show({ global = false })<cr>"; desc = "Buffer Keymaps (which-key)"; }

  # === Noice ===
  { mode = ["n" "i" "s"]; key = "<c-b>"; action = "<cmd>lua if not require('noice.lsp').scroll(-4) then return '<c-b>' end<cr>"; desc = "Scroll Backward"; expr = true; }
  { mode = ["n" "i" "s"]; key = "<c-f>"; action = "<cmd>lua if not require('noice.lsp').scroll(4) then return '<c-f>' end<cr>"; desc = "Scroll Forward"; expr = true; }
  { mode = ["n"]; key = "<leader>sn"; action = ""; desc = "+noice"; }
  { mode = ["n"]; key = "<leader>sna"; action = "<cmd>NoiceAll<cr>"; desc = "Noice All"; }
  { mode = ["n"]; key = "<leader>snd"; action = "<cmd>NoiceDismiss<cr>"; desc = "Dismiss All"; }
  { mode = ["n"]; key = "<leader>snh"; action = "<cmd>NoiceHistory<cr>"; desc = "Noice History"; }
  { mode = ["n"]; key = "<leader>snl"; action = "<cmd>NoiceLast<cr>"; desc = "Noice Last Message"; }
  { mode = ["n"]; key = "<leader>snt"; action = "<cmd>NoiceTelescope<cr>"; desc = "Noice Picker (Telescope/FzfLua)"; }
  { mode = ["c"]; key = "<S-Enter>"; action = "<cmd>lua require('noice').redirect(vim.fn.getcmdline())<cr>"; desc = "Redirect Cmdline"; }

  # === Bufferline ===
  { mode = "n"; key = "<leader>bl"; action = "<cmd>BufferLineCloseLeft<cr>"; desc = "Delete buffers to the left"; }
  { mode = "n"; key = "<leader>bp"; action = "<cmd>BufferLineTogglePin<cr>"; desc = "Toggle pin"; }
  { mode = "n"; key = "<leader>bP"; action = "<cmd>BufferLineGroupClose ungrouped<cr>"; desc = "Delete non-pinned buffers"; }
  { mode = "n"; key = "<leader>br"; action = "<cmd>BufferLineCloseRight<cr>"; desc = "Delete buffers to the right"; }
  { mode = "n"; key = "[B"; action = "<cmd>BufferLineMovePrev<cr>"; desc = "Move buffer prev"; }
  { mode = "n"; key = "]B"; action = "<cmd>BufferLineMoveNext<cr>"; desc = "Move buffer next"; }

  # === Edgy ===
  { key = "<leader>ue"; action = "<cmd>lua require('edgy').toggle()<cr>"; mode = ["n"]; desc = "Edgy Toggle"; }
  { key = "<leader>uE"; action = "<cmd>lua require('edgy').select_window()<cr>"; mode = ["n"]; desc = "Edgy Select Window"; }
]
