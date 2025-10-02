# Bufferline keymaps - 10 keymaps from LazyVim bufferline.nvim section
[
  # 1-4. Buffer management
  { mode = "n"; key = "<leader>bl"; action = "<cmd>BufferLineCloseLeft<cr>"; desc = "Delete buffers to the left"; }
  { mode = "n"; key = "<leader>bp"; action = "<cmd>BufferLineTogglePin<cr>"; desc = "Toggle pin"; }
  { mode = "n"; key = "<leader>bP"; action = "<cmd>BufferLineGroupClose ungrouped<cr>"; desc = "Delete non-pinned buffers"; }
  { mode = "n"; key = "<leader>br"; action = "<cmd>BufferLineCloseRight<cr>"; desc = "Delete buffers to the right"; }
  
  # 5-8. Buffer navigation and movement
  { mode = "n"; key = "[b"; action = "<cmd>BufferLineCyclePrev<cr>"; desc = "Prev buffer"; }
  { mode = "n"; key = "[B"; action = "<cmd>BufferLineMovePrev<cr>"; desc = "Move buffer prev"; }
  { mode = "n"; key = "]b"; action = "<cmd>BufferLineCycleNext<cr>"; desc = "Next buffer"; }
  { mode = "n"; key = "]B"; action = "<cmd>BufferLineMoveNext<cr>"; desc = "Move buffer next"; }
  
  # 9-10. Quick navigation
  { mode = "n"; key = "<S-h>"; action = "<cmd>BufferLineCyclePrev<cr>"; desc = "Prev buffer"; }
  { mode = "n"; key = "<S-l>"; action = "<cmd>BufferLineCycleNext<cr>"; desc = "Next buffer"; }
]