# LSP keymaps - 19 keymaps from LazyVim LSP section
[
  # 1. LSP Info
  { mode = "n"; key = "<leader>cl"; action = "<cmd>LspInfo<cr>"; }
  
  # 2-6. Navigation
  { mode = "n"; key = "gd"; action = "<cmd>lua vim.lsp.buf.definition()<cr>"; }
  { mode = "n"; key = "gr"; action = "<cmd>lua vim.lsp.buf.references()<cr>"; }
  { mode = "n"; key = "gI"; action = "<cmd>lua vim.lsp.buf.implementation()<cr>"; }
  { mode = "n"; key = "gy"; action = "<cmd>lua vim.lsp.buf.type_definition()<cr>"; }
  { mode = "n"; key = "gD"; action = "<cmd>lua vim.lsp.buf.declaration()<cr>"; }
  
  # 7-9. Help and hover
  { mode = "n"; key = "K"; action = "<cmd>lua vim.lsp.buf.hover()<cr>"; }
  { mode = "n"; key = "gK"; action = "<cmd>lua vim.lsp.buf.signature_help()<cr>"; }
  { mode = "i"; key = "<c-k>"; action = "<cmd>lua vim.lsp.buf.signature_help()<cr>"; }
  
  # 10-15. Code actions and refactoring
  { mode = ["n" "v"]; key = "<leader>ca"; action = "<cmd>lua vim.lsp.buf.code_action()<cr>"; }
  { mode = ["n" "v"]; key = "<leader>cc"; action = "<cmd>lua vim.lsp.codelens.run()<cr>"; }
  { mode = "n"; key = "<leader>cC"; action = "<cmd>lua vim.lsp.codelens.refresh()<cr>"; }
  { mode = "n"; key = "<leader>cR"; action = "<cmd>lua vim.lsp.buf.rename()<cr>"; }
  { mode = "n"; key = "<leader>cr"; action = "<cmd>lua vim.lsp.buf.rename()<cr>"; }
  { mode = "n"; key = "<leader>cA"; action = "<cmd>lua vim.lsp.buf.code_action()<cr>"; }
  
  # 16-19. Reference navigation
  { mode = "n"; key = "]]"; action = "<cmd>lua vim.lsp.buf.references()<cr>"; }
  { mode = "n"; key = "[["; action = "<cmd>lua vim.lsp.buf.references()<cr>"; }
  { mode = "n"; key = "<a-n>"; action = "<cmd>lua vim.lsp.buf.references()<cr>"; }
  { mode = "n"; key = "<a-p>"; action = "<cmd>lua vim.lsp.buf.references()<cr>"; }
]