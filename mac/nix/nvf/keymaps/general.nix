# General keymaps - 91 keymaps from LazyVim General section
[
  # 1-2. j/<Down> - Down (n, x)
  { mode = ["n" "x"]; key = "j"; action = "gj"; desc = "Move down (display lines)"; }
  { mode = ["n" "x"]; key = "<Down>"; action = "gj"; desc = "Move down (display lines)"; }
  
  # 3-4. k/<Up> - Up (n, x)
  { mode = ["n" "x"]; key = "k"; action = "gk"; desc = "Move up (display lines)"; }
  { mode = ["n" "x"]; key = "<Up>"; action = "gk"; desc = "Move up (display lines)"; }
  
  # 5-8. Window navigation
  { mode = "n"; key = "<C-h>"; action = "<C-w>h"; desc = "Go to left window"; }
  { mode = "n"; key = "<C-j>"; action = "<C-w>j"; desc = "Go to lower window"; }
  { mode = "n"; key = "<C-k>"; action = "<C-w>k"; desc = "Go to upper window"; }
  { mode = "n"; key = "<C-l>"; action = "<C-w>l"; desc = "Go to right window"; }
  
  # 9-12. Window resizing
  { mode = "n"; key = "<C-Up>"; action = "<cmd>resize +2<cr>"; desc = "Increase window height"; }
  { mode = "n"; key = "<C-Down>"; action = "<cmd>resize -2<cr>"; desc = "Decrease window height"; }
  { mode = "n"; key = "<C-Left>"; action = "<cmd>vertical resize -2<cr>"; desc = "Decrease window width"; }
  { mode = "n"; key = "<C-Right>"; action = "<cmd>vertical resize +2<cr>"; desc = "Increase window width"; }
  
  # 13-14. Move lines (different actions per mode)
  { mode = "n"; key = "<A-j>"; action = "<cmd>m .+1<cr>=="; desc = "Move line down"; }
  { mode = "i"; key = "<A-j>"; action = "<esc><cmd>m .+1<cr>==gi"; desc = "Move line down"; }
  { mode = "v"; key = "<A-j>"; action = ":m '>+1<cr>gv=gv"; desc = "Move selection down"; }
  { mode = "n"; key = "<A-k>"; action = "<cmd>m .-2<cr>=="; desc = "Move line up"; }
  { mode = "i"; key = "<A-k>"; action = "<esc><cmd>m .-2<cr>==gi"; desc = "Move line up"; }
  { mode = "v"; key = "<A-k>"; action = ":m '<-2<cr>gv=gv"; desc = "Move selection up"; }
  
  # 15-18. Buffer navigation
  { mode = "n"; key = "<S-h>"; action = "<cmd>bprevious<cr>"; desc = "Previous buffer"; }
  { mode = "n"; key = "<S-l>"; action = "<cmd>bnext<cr>"; desc = "Next buffer"; }
  { mode = "n"; key = "[b"; action = "<cmd>bprevious<cr>"; desc = "Previous buffer"; }
  { mode = "n"; key = "]b"; action = "<cmd>bnext<cr>"; desc = "Next buffer"; }
  
  # 19-23. Buffer management
  { mode = "n"; key = "<leader>bb"; action = "<cmd>e #<cr>"; desc = "Switch to other buffer"; }
  { mode = "n"; key = "<leader>`"; action = "<cmd>e #<cr>"; desc = "Switch to other buffer"; }
  { mode = "n"; key = "<leader>bd"; action = "<cmd>bdelete<cr>"; desc = "Delete buffer"; }
  { mode = "n"; key = "<leader>bo"; action = "<cmd>%bd|e#|bd#<cr>"; desc = "Delete other buffers"; }
  { mode = "n"; key = "<leader>bD"; action = "<cmd>bdelete!<cr><cmd>close<cr>"; desc = "Delete buffer and window"; }
  
  # 24-25. Clear search
  { mode = ["i" "n" "s"]; key = "<esc>"; action = "<cmd>noh<cr><esc>"; desc = "Escape and clear hlsearch"; }
  { mode = "n"; key = "<leader>ur"; action = "<cmd>nohlsearch<bar>diffupdate<bar>normal! <C-L><cr>"; desc = "Redraw / clear hlsearch / diff update"; }
  
  # 26-27. Search navigation
  { mode = ["n" "x" "o"]; key = "n"; action = "nzzzv"; desc = "Next search result"; }
  { mode = ["n" "x" "o"]; key = "N"; action = "Nzzzv"; desc = "Previous search result"; }
  
  # 28. Save file
  { mode = ["i" "x" "n" "s"]; key = "<C-s>"; action = "<cmd>w<cr><esc>"; desc = "Save file"; }
  
  # 29-32. Misc commands
  { mode = "n"; key = "<leader>K"; action = "<cmd>norm! K<cr>"; desc = "Keywordprg"; }
  { mode = "n"; key = "gco"; action = "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>"; desc = "Add comment below"; }
  { mode = "n"; key = "gcO"; action = "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>"; desc = "Add comment above"; }
  # { mode = "n"; key = "<leader>l"; action = "<cmd>Lazy<cr>"; }
  
  # 33-37. File and quickfix
  { mode = "n"; key = "<leader>fn"; action = "<cmd>enew<cr>"; desc = "New file"; }
  { mode = "n"; key = "<leader>xl"; action = "<cmd>lopen<cr>"; desc = "Location list"; }
  { mode = "n"; key = "<leader>xq"; action = "<cmd>copen<cr>"; desc = "Quickfix list"; }
  { mode = "n"; key = "[q"; action = "<cmd>cprev<cr>"; desc = "Previous quickfix"; }
  { mode = "n"; key = "]q"; action = "<cmd>cnext<cr>"; desc = "Next quickfix"; }
  
  # 38-45. Format and diagnostics
  { mode = ["n" "v"]; key = "<leader>cf"; action = "<cmd>lua vim.lsp.buf.format()<cr>"; desc = "Format"; }
  { mode = "n"; key = "<leader>cd"; action = "<cmd>lua vim.diagnostic.open_float()<cr>"; desc = "Line diagnostics"; }
  { mode = "n"; key = "]d"; action = "<cmd>lua vim.diagnostic.goto_next()<cr>"; desc = "Next diagnostic"; }
  { mode = "n"; key = "[d"; action = "<cmd>lua vim.diagnostic.goto_prev()<cr>"; desc = "Previous diagnostic"; }
  { mode = "n"; key = "]e"; action = "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<cr>"; desc = "Next error"; }
  { mode = "n"; key = "[e"; action = "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<cr>"; desc = "Previous error"; }
  { mode = "n"; key = "]w"; action = "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.WARN})<cr>"; desc = "Next warning"; }
  { mode = "n"; key = "[w"; action = "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.WARN})<cr>"; desc = "Previous warning"; }
  
  # 46-63. UI toggles
  { mode = "n"; key = "<leader>uf"; action = "<cmd>lua vim.g.autoformat = not vim.g.autoformat<cr>"; desc = "Toggle auto format (global)"; }
  { mode = "n"; key = "<leader>uF"; action = "<cmd>lua vim.b.autoformat = not vim.b.autoformat<cr>"; desc = "Toggle auto format (buffer)"; }
  { mode = "n"; key = "<leader>us"; action = "<cmd>setlocal spell!<cr>"; desc = "Toggle spelling"; }
  { mode = "n"; key = "<leader>uw"; action = "<cmd>setlocal wrap!<cr>"; desc = "Toggle word wrap"; }
  { mode = "n"; key = "<leader>uL"; action = "<cmd>setlocal relativenumber!<cr>"; desc = "Toggle relative line numbers"; }
  { mode = "n"; key = "<leader>ud"; action = "<cmd>lua vim.diagnostic.enable(not vim.diagnostic.is_enabled())<cr>"; desc = "Toggle diagnostics"; }
  { mode = "n"; key = "<leader>ul"; action = "<cmd>setlocal number!<cr>"; desc = "Toggle line numbers"; }
  { mode = "n"; key = "<leader>uc"; action = "<cmd>setlocal conceallevel=<cmd>echo &conceallevel == 0 and 2 or 0<cr>"; desc = "Toggle conceal"; }
  { mode = "n"; key = "<leader>uA"; action = "<cmd>set showtabline=<cmd>echo &showtabline == 0 and 2 or 0<cr>"; desc = "Toggle tabline"; }
  { mode = "n"; key = "<leader>uT"; action = "<cmd>TSToggle highlight<cr>"; desc = "Toggle treesitter highlight"; }
  { mode = "n"; key = "<leader>ub"; action = "<cmd>set background=<cmd>echo &background == 'dark' and 'light' or 'dark'<cr>"; desc = "Toggle background"; }
  { mode = "n"; key = "<leader>uD"; action = "<cmd>lua print('Dimming toggle not implemented')<cr>"; desc = "Toggle dimming"; }
  { mode = "n"; key = "<leader>ua"; action = "<cmd>lua print('Animations toggle not implemented')<cr>"; desc = "Toggle animations"; }
  { mode = "n"; key = "<leader>ug"; action = "<cmd>lua print('Indent guides toggle not implemented')<cr>"; desc = "Toggle indent guides"; }
  { mode = "n"; key = "<leader>uS"; action = "<cmd>lua print('Smooth scroll toggle not implemented')<cr>"; desc = "Toggle smooth scroll"; }
  { mode = "n"; key = "<leader>dpp"; action = "<cmd>lua print('Profiler toggle not implemented')<cr>"; desc = "Toggle profiler"; }
  { mode = "n"; key = "<leader>dph"; action = "<cmd>lua print('Profiler highlights toggle not implemented')<cr>"; desc = "Toggle profiler highlights"; }
  { mode = "n"; key = "<leader>uh"; action = "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<cr>"; desc = "Toggle inlay hints"; }
  
  # 64-69. Git placeholders
  { mode = "n"; key = "<leader>gL"; action = "<cmd>lua print('Git log cwd not implemented')<cr>"; desc = "Git log (cwd)"; }
  { mode = "n"; key = "<leader>gb"; action = "<cmd>lua print('Git blame not implemented')<cr>"; desc = "Git blame"; }
  { mode = "n"; key = "<leader>gf"; action = "<cmd>lua print('Git file history not implemented')<cr>"; desc = "Git file history"; }
  { mode = "n"; key = "<leader>gl"; action = "<cmd>lua print('Git log not implemented')<cr>"; desc = "Git log"; }
  { mode = ["n" "x"]; key = "<leader>gB"; action = "<cmd>lua print('Git browse open not implemented')<cr>"; desc = "Git browse"; }
  { mode = ["n" "x"]; key = "<leader>gY"; action = "<cmd>lua print('Git browse copy not implemented')<cr>"; desc = "Git browse (copy)"; }
  
  # 70-73. System commands
  { mode = "n"; key = "<leader>qq"; action = "<cmd>qa<cr>"; desc = "Quit all"; }
  { mode = "n"; key = "<leader>ui"; action = "<cmd>Inspect<cr>"; desc = "Inspect pos"; }
  { mode = "n"; key = "<leader>uI"; action = "<cmd>InspectTree<cr>"; desc = "Inspect tree"; }
  # { mode = "n"; key = "<leader>L"; action = "<cmd>lua print('LazyVim changelog not available in NVF')<cr>"; }
  
  # 74-78. Terminal
  { mode = "n"; key = "<leader>fT"; action = "<cmd>terminal<cr>"; desc = "Terminal (cwd)"; }
  { mode = "n"; key = "<leader>ft"; action = "<cmd>terminal<cr>"; desc = "Terminal (root dir)"; }
  { mode = "n"; key = "<c-/>"; action = "<cmd>terminal<cr>"; desc = "Terminal (root dir)"; }
  { mode = ["n" "t"]; key = "<c-_>"; action = "<c-/>"; desc = "Terminal (which-key)"; }
  { mode = "t"; key = "<C-/>"; action = "<cmd>close<cr>"; desc = "Hide terminal"; }
  
  # 79-84. Windows
  { mode = "n"; key = "<leader>-"; action = "<C-W>s"; desc = "Split window below"; }
  { mode = "n"; key = "<leader>|"; action = "<C-W>v"; desc = "Split window right"; }
  { mode = "n"; key = "<leader>wd"; action = "<C-W>c"; desc = "Delete window"; }
  { mode = "n"; key = "<leader>wm"; action = "<cmd>lua print('Zoom mode not implemented')<cr>"; desc = "Maximize"; }
  { mode = "n"; key = "<leader>uZ"; action = "<cmd>lua print('Zoom mode not implemented')<cr>"; desc = "Toggle zoom"; }
  { mode = "n"; key = "<leader>uz"; action = "<cmd>lua print('Zen mode not implemented')<cr>"; desc = "Toggle zen mode"; }
  
  # 85-91. Tabs
  { mode = "n"; key = "<leader><tab>l"; action = "<cmd>tablast<cr>"; desc = "Last tab"; }
  { mode = "n"; key = "<leader><tab>o"; action = "<cmd>tabonly<cr>"; desc = "Close other tabs"; }
  { mode = "n"; key = "<leader><tab>f"; action = "<cmd>tabfirst<cr>"; desc = "First tab"; }
  { mode = "n"; key = "<leader><tab><tab>"; action = "<cmd>tabnew<cr>"; desc = "New tab"; }
  { mode = "n"; key = "<leader><tab>]"; action = "<cmd>tabnext<cr>"; desc = "Next tab"; }
  { mode = "n"; key = "<leader><tab>d"; action = "<cmd>tabclose<cr>"; desc = "Close tab"; }
  { mode = "n"; key = "<leader><tab>["; action = "<cmd>tabprevious<cr>"; desc = "Previous tab"; }
]