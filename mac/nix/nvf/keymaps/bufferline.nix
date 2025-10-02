# Bufferline keymaps - 10 keymaps from LazyVim bufferline.nvim section
[
  # 1-4. Buffer management
  { mode = "n"; key = "<leader>bl"; action = "<cmd>BufferLineCloseLeft<cr>"; }
  { mode = "n"; key = "<leader>bp"; action = "<cmd>BufferLineTogglePin<cr>"; }
  { mode = "n"; key = "<leader>bP"; action = "<cmd>BufferLineGroupClose ungrouped<cr>"; }
  { mode = "n"; key = "<leader>br"; action = "<cmd>BufferLineCloseRight<cr>"; }
  
  # 5-8. Buffer navigation and movement
  { mode = "n"; key = "[b"; action = "<cmd>BufferLineCyclePrev<cr>"; }
  { mode = "n"; key = "[B"; action = "<cmd>BufferLineMovePrev<cr>"; }
  { mode = "n"; key = "]b"; action = "<cmd>BufferLineCycleNext<cr>"; }
  { mode = "n"; key = "]B"; action = "<cmd>BufferLineMoveNext<cr>"; }
  
  # 9-10. Quick navigation
  { mode = "n"; key = "<S-h>"; action = "<cmd>BufferLineCyclePrev<cr>"; }
  { mode = "n"; key = "<S-l>"; action = "<cmd>BufferLineCycleNext<cr>"; }
]