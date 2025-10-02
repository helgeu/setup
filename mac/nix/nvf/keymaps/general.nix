# General keymaps - 91 keymaps from LazyVim General section
[
  # 1-2. j/<Down> - Down (n, x)
  { mode = ["n" "x"]; key = "j"; action = "gj"; }
  { mode = ["n" "x"]; key = "<Down>"; action = "gj"; }
  
  # 3-4. k/<Up> - Up (n, x)
  { mode = ["n" "x"]; key = "k"; action = "gk"; }
  { mode = ["n" "x"]; key = "<Up>"; action = "gk"; }
  
  # 5-8. Window navigation
  { mode = "n"; key = "<C-h>"; action = "<C-w>h"; }
  { mode = "n"; key = "<C-j>"; action = "<C-w>j"; }
  { mode = "n"; key = "<C-k>"; action = "<C-w>k"; }
  { mode = "n"; key = "<C-l>"; action = "<C-w>l"; }
  
  # 9-12. Window resizing
  { mode = "n"; key = "<C-Up>"; action = "<cmd>resize +2<cr>"; }
  { mode = "n"; key = "<C-Down>"; action = "<cmd>resize -2<cr>"; }
  { mode = "n"; key = "<C-Left>"; action = "<cmd>vertical resize -2<cr>"; }
  { mode = "n"; key = "<C-Right>"; action = "<cmd>vertical resize +2<cr>"; }
  
  # 13-14. Move lines (different actions per mode)
  { mode = "n"; key = "<A-j>"; action = "<cmd>m .+1<cr>=="; }
  { mode = "i"; key = "<A-j>"; action = "<esc><cmd>m .+1<cr>==gi"; }
  { mode = "v"; key = "<A-j>"; action = ":m '>+1<cr>gv=gv"; }
  { mode = "n"; key = "<A-k>"; action = "<cmd>m .-2<cr>=="; }
  { mode = "i"; key = "<A-k>"; action = "<esc><cmd>m .-2<cr>==gi"; }
  { mode = "v"; key = "<A-k>"; action = ":m '<-2<cr>gv=gv"; }
  
  # 15-18. Buffer navigation
  { mode = "n"; key = "<S-h>"; action = "<cmd>bprevious<cr>"; }
  { mode = "n"; key = "<S-l>"; action = "<cmd>bnext<cr>"; }
  { mode = "n"; key = "[b"; action = "<cmd>bprevious<cr>"; }
  { mode = "n"; key = "]b"; action = "<cmd>bnext<cr>"; }
  
  # 19-23. Buffer management
  { mode = "n"; key = "<leader>bb"; action = "<cmd>e #<cr>"; }
  { mode = "n"; key = "<leader>`"; action = "<cmd>e #<cr>"; }
  { mode = "n"; key = "<leader>bd"; action = "<cmd>bdelete<cr>"; }
  { mode = "n"; key = "<leader>bo"; action = "<cmd>%bd|e#|bd#<cr>"; }
  { mode = "n"; key = "<leader>bD"; action = "<cmd>bdelete!<cr><cmd>close<cr>"; }
  
  # 24-25. Clear search
  { mode = ["i" "n" "s"]; key = "<esc>"; action = "<cmd>noh<cr><esc>"; }
  { mode = "n"; key = "<leader>ur"; action = "<cmd>nohlsearch<bar>diffupdate<bar>normal! <C-L><cr>"; }
  
  # 26-27. Search navigation
  { mode = ["n" "x" "o"]; key = "n"; action = "nzzzv"; }
  { mode = ["n" "x" "o"]; key = "N"; action = "Nzzzv"; }
  
  # 28. Save file
  { mode = ["i" "x" "n" "s"]; key = "<C-s>"; action = "<cmd>w<cr><esc>"; }
  
  # 29-32. Misc commands
  { mode = "n"; key = "<leader>K"; action = "<cmd>norm! K<cr>"; }
  { mode = "n"; key = "gco"; action = "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>"; }
  { mode = "n"; key = "gcO"; action = "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>"; }
  # { mode = "n"; key = "<leader>l"; action = "<cmd>Lazy<cr>"; }
  
  # 33-37. File and quickfix
  { mode = "n"; key = "<leader>fn"; action = "<cmd>enew<cr>"; }
  { mode = "n"; key = "<leader>xl"; action = "<cmd>lopen<cr>"; }
  { mode = "n"; key = "<leader>xq"; action = "<cmd>copen<cr>"; }
  { mode = "n"; key = "[q"; action = "<cmd>cprev<cr>"; }
  { mode = "n"; key = "]q"; action = "<cmd>cnext<cr>"; }
  
  # 38-45. Format and diagnostics
  { mode = ["n" "v"]; key = "<leader>cf"; action = "<cmd>lua vim.lsp.buf.format()<cr>"; }
  { mode = "n"; key = "<leader>cd"; action = "<cmd>lua vim.diagnostic.open_float()<cr>"; }
  { mode = "n"; key = "]d"; action = "<cmd>lua vim.diagnostic.goto_next()<cr>"; }
  { mode = "n"; key = "[d"; action = "<cmd>lua vim.diagnostic.goto_prev()<cr>"; }
  { mode = "n"; key = "]e"; action = "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<cr>"; }
  { mode = "n"; key = "[e"; action = "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<cr>"; }
  { mode = "n"; key = "]w"; action = "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.WARN})<cr>"; }
  { mode = "n"; key = "[w"; action = "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.WARN})<cr>"; }
  
  # 46-63. UI toggles
  { mode = "n"; key = "<leader>uf"; action = "<cmd>lua vim.g.autoformat = not vim.g.autoformat<cr>"; }
  { mode = "n"; key = "<leader>uF"; action = "<cmd>lua vim.b.autoformat = not vim.b.autoformat<cr>"; }
  { mode = "n"; key = "<leader>us"; action = "<cmd>setlocal spell!<cr>"; }
  { mode = "n"; key = "<leader>uw"; action = "<cmd>setlocal wrap!<cr>"; }
  { mode = "n"; key = "<leader>uL"; action = "<cmd>setlocal relativenumber!<cr>"; }
  { mode = "n"; key = "<leader>ud"; action = "<cmd>lua vim.diagnostic.enable(not vim.diagnostic.is_enabled())<cr>"; }
  { mode = "n"; key = "<leader>ul"; action = "<cmd>setlocal number!<cr>"; }
  { mode = "n"; key = "<leader>uc"; action = "<cmd>setlocal conceallevel=<cmd>echo &conceallevel == 0 and 2 or 0<cr>"; }
  { mode = "n"; key = "<leader>uA"; action = "<cmd>set showtabline=<cmd>echo &showtabline == 0 and 2 or 0<cr>"; }
  { mode = "n"; key = "<leader>uT"; action = "<cmd>TSToggle highlight<cr>"; }
  { mode = "n"; key = "<leader>ub"; action = "<cmd>set background=<cmd>echo &background == 'dark' and 'light' or 'dark'<cr>"; }
  { mode = "n"; key = "<leader>uD"; action = "<cmd>lua print('Dimming toggle not implemented')<cr>"; }
  { mode = "n"; key = "<leader>ua"; action = "<cmd>lua print('Animations toggle not implemented')<cr>"; }
  { mode = "n"; key = "<leader>ug"; action = "<cmd>lua print('Indent guides toggle not implemented')<cr>"; }
  { mode = "n"; key = "<leader>uS"; action = "<cmd>lua print('Smooth scroll toggle not implemented')<cr>"; }
  { mode = "n"; key = "<leader>dpp"; action = "<cmd>lua print('Profiler toggle not implemented')<cr>"; }
  { mode = "n"; key = "<leader>dph"; action = "<cmd>lua print('Profiler highlights toggle not implemented')<cr>"; }
  { mode = "n"; key = "<leader>uh"; action = "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<cr>"; }
  
  # 64-69. Git placeholders
  { mode = "n"; key = "<leader>gL"; action = "<cmd>lua print('Git log cwd not implemented')<cr>"; }
  { mode = "n"; key = "<leader>gb"; action = "<cmd>lua print('Git blame not implemented')<cr>"; }
  { mode = "n"; key = "<leader>gf"; action = "<cmd>lua print('Git file history not implemented')<cr>"; }
  { mode = "n"; key = "<leader>gl"; action = "<cmd>lua print('Git log not implemented')<cr>"; }
  { mode = ["n" "x"]; key = "<leader>gB"; action = "<cmd>lua print('Git browse open not implemented')<cr>"; }
  { mode = ["n" "x"]; key = "<leader>gY"; action = "<cmd>lua print('Git browse copy not implemented')<cr>"; }
  
  # 70-73. System commands
  { mode = "n"; key = "<leader>qq"; action = "<cmd>qa<cr>"; }
  { mode = "n"; key = "<leader>ui"; action = "<cmd>Inspect<cr>"; }
  { mode = "n"; key = "<leader>uI"; action = "<cmd>InspectTree<cr>"; }
  # { mode = "n"; key = "<leader>L"; action = "<cmd>lua print('LazyVim changelog not available in NVF')<cr>"; }
  
  # 74-78. Terminal
  { mode = "n"; key = "<leader>fT"; action = "<cmd>terminal<cr>"; }
  { mode = "n"; key = "<leader>ft"; action = "<cmd>terminal<cr>"; }
  { mode = "n"; key = "<c-/>"; action = "<cmd>terminal<cr>"; }
  { mode = ["n" "t"]; key = "<c-_>"; action = "<c-/>"; }
  { mode = "t"; key = "<C-/>"; action = "<cmd>close<cr>"; }
  
  # 79-84. Windows
  { mode = "n"; key = "<leader>-"; action = "<C-W>s"; }
  { mode = "n"; key = "<leader>|"; action = "<C-W>v"; }
  { mode = "n"; key = "<leader>wd"; action = "<C-W>c"; }
  { mode = "n"; key = "<leader>wm"; action = "<cmd>lua print('Zoom mode not implemented')<cr>"; }
  { mode = "n"; key = "<leader>uZ"; action = "<cmd>lua print('Zoom mode not implemented')<cr>"; }
  { mode = "n"; key = "<leader>uz"; action = "<cmd>lua print('Zen mode not implemented')<cr>"; }
  
  # 85-91. Tabs
  { mode = "n"; key = "<leader><tab>l"; action = "<cmd>tablast<cr>"; }
  { mode = "n"; key = "<leader><tab>o"; action = "<cmd>tabonly<cr>"; }
  { mode = "n"; key = "<leader><tab>f"; action = "<cmd>tabfirst<cr>"; }
  { mode = "n"; key = "<leader><tab><tab>"; action = "<cmd>tabnew<cr>"; }
  { mode = "n"; key = "<leader><tab>]"; action = "<cmd>tabnext<cr>"; }
  { mode = "n"; key = "<leader><tab>d"; action = "<cmd>tabclose<cr>"; }
  { mode = "n"; key = "<leader><tab>["; action = "<cmd>tabprevious<cr>"; }
]