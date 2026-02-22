# Editor keymaps - refactoring, surround, increment/decrement, yank
# Consolidated from: refactoring.nix, dial.nix, mini-surround.nix, mini-surround-extra.nix, yanky.nix, conform.nix, neogen.nix, grug-far.nix
[
  # === Conform (format injected) ===
  { mode = ["n" "v"]; key = "<leader>cF"; action = "<cmd>lua require('conform').format({ formatters = { 'injected' }, timeout_ms = 3000 })<cr>"; desc = "Format Injected Langs"; }

  # === Neogen (annotations) ===
  { mode = ["n"]; key = "<leader>cn"; action = "<cmd>lua require('neogen').generate()<cr>"; desc = "Generate Annotations (Neogen)"; }

  # === Grug-far (search & replace) ===
  { mode = ["n" "v"]; key = "<leader>sr"; action = "<cmd>lua require('grug-far').open({ transient = true })<cr>"; desc = "Search and Replace"; }

  # === Refactoring ===
  { mode = ["n" "x"]; key = "<leader>r"; action = ""; desc = "+refactor"; }
  { mode = ["n" "x"]; key = "<leader>rb"; action = "<cmd>lua require('refactoring').refactor('Extract Block')<cr>"; desc = "Extract Block"; }
  { mode = ["n"]; key = "<leader>rc"; action = "<cmd>lua require('refactoring').debug.cleanup({})<cr>"; desc = "Debug Cleanup"; }
  { mode = ["n" "x"]; key = "<leader>rf"; action = "<cmd>lua require('refactoring').refactor('Extract Function')<cr>"; desc = "Extract Function"; }
  { mode = ["n" "x"]; key = "<leader>rF"; action = "<cmd>lua require('refactoring').refactor('Extract Function To File')<cr>"; desc = "Extract Function To File"; }
  { mode = ["n" "x"]; key = "<leader>ri"; action = "<cmd>lua require('refactoring').refactor('Inline Variable')<cr>"; desc = "Inline Variable"; }
  { mode = ["n" "x"]; key = "<leader>rp"; action = "<cmd>lua require('refactoring').debug.print_var({})<cr>"; desc = "Debug Print Variable"; }
  { mode = ["n"]; key = "<leader>rP"; action = "<cmd>lua require('refactoring').debug.print_var({ normal = true })<cr>"; desc = "Debug Print"; }
  { mode = ["n" "x"]; key = "<leader>rs"; action = "<cmd>lua require('refactoring').select_refactor()<cr>"; desc = "Refactor"; }
  { mode = ["n" "x"]; key = "<leader>rx"; action = "<cmd>lua require('refactoring').refactor('Extract Variable')<cr>"; desc = "Extract Variable"; }

  # === Dial (increment/decrement) ===
  { mode = ["n" "v"]; key = "<C-a>"; action = "<cmd>lua require('dial.map').manipulate('increment', 'normal')<cr>"; desc = "Increment"; }
  { mode = ["n" "v"]; key = "<C-x>"; action = "<cmd>lua require('dial.map').manipulate('decrement', 'normal')<cr>"; desc = "Decrement"; }
  { mode = ["n" "v"]; key = "g<C-a>"; action = "<cmd>lua require('dial.map').manipulate('increment', 'gnormal')<cr>"; desc = "Increment"; }
  { mode = ["n" "v"]; key = "g<C-x>"; action = "<cmd>lua require('dial.map').manipulate('decrement', 'gnormal')<cr>"; desc = "Decrement"; }

  # === Mini.surround ===
  { mode = ["n"]; key = "gz"; action = ""; desc = "+surround"; }
  { mode = ["n" "v"]; key = "gsa"; action = "<cmd>lua require('mini.surround').add('visual')<cr>"; desc = "Add Surrounding"; }
  { mode = ["n"]; key = "gsd"; action = "<cmd>lua require('mini.surround').delete()<cr>"; desc = "Delete Surrounding"; }
  { mode = ["n"]; key = "gsf"; action = "<cmd>lua require('mini.surround').find_right()<cr>"; desc = "Find Right Surrounding"; }
  { mode = ["n"]; key = "gsF"; action = "<cmd>lua require('mini.surround').find_left()<cr>"; desc = "Find Left Surrounding"; }
  { mode = ["n"]; key = "gsh"; action = "<cmd>lua require('mini.surround').highlight()<cr>"; desc = "Highlight Surrounding"; }
  { mode = ["n"]; key = "gsn"; action = "<cmd>lua require('mini.surround').update_n_lines()<cr>"; desc = "Update `MiniSurround.config.n_lines`"; }
  { mode = ["n"]; key = "gsr"; action = "<cmd>lua require('mini.surround').replace()<cr>"; desc = "Replace Surrounding"; }

  # === Yanky ===
  { mode = ["n" "x"]; key = "<leader>p"; action = "<cmd>YankyRingHistory<cr>"; desc = "Open Yank History"; }
  { mode = ["n"]; key = "<p"; action = "<Plug>(YankyPutIndentAfterLinewise)"; desc = "Put and Indent Left"; }
  { mode = ["n"]; key = "<P"; action = "<Plug>(YankyPutIndentBeforeLinewise)"; desc = "Put Before and Indent Left"; }
  { mode = ["n"]; key = "=p"; action = "<Plug>(YankyPutAfterFilter)"; desc = "Put After Applying a Filter"; }
  { mode = ["n"]; key = "=P"; action = "<Plug>(YankyPutBeforeFilter)"; desc = "Put Before Applying a Filter"; }
  { mode = ["n"]; key = ">p"; action = "<Plug>(YankyPutIndentAfterShiftRight)"; desc = "Put and Indent Right"; }
  { mode = ["n"]; key = ">P"; action = "<Plug>(YankyPutIndentBeforeShiftRight)"; desc = "Put Before and Indent Right"; }
  { mode = ["n"]; key = "[p"; action = "<Plug>(YankyPutIndentBeforeLinewise)"; desc = "Put Indented Before Cursor (Linewise)"; }
  { mode = ["n"]; key = "[P"; action = "<Plug>(YankyPutIndentBeforeLinewise)"; desc = "Put Indented Before Cursor (Linewise)"; }
  { mode = ["n"]; key = "[y"; action = "<Plug>(YankyCycleForward)"; desc = "Cycle Forward Through Yank History"; }
  { mode = ["n"]; key = "]p"; action = "<Plug>(YankyPutIndentAfterLinewise)"; desc = "Put Indented After Cursor (Linewise)"; }
  { mode = ["n"]; key = "]P"; action = "<Plug>(YankyPutIndentAfterLinewise)"; desc = "Put Indented After Cursor (Linewise)"; }
  { mode = ["n"]; key = "]y"; action = "<Plug>(YankyCycleBackward)"; desc = "Cycle Backward Through Yank History"; }
  { mode = ["n" "x"]; key = "gp"; action = "<Plug>(YankyGPutAfter)"; desc = "Put Text After Selection"; }
  { mode = ["n" "x"]; key = "gP"; action = "<Plug>(YankyGPutBefore)"; desc = "Put Text Before Selection"; }
  { mode = ["n" "x"]; key = "p"; action = "<Plug>(YankyPutAfter)"; desc = "Put Text After Cursor"; }
  { mode = ["n" "x"]; key = "P"; action = "<Plug>(YankyPutBefore)"; desc = "Put Text Before Cursor"; }
  { mode = ["n" "x"]; key = "y"; action = "<Plug>(YankyYank)"; desc = "Yank Text"; }
]
