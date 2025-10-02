# LSP keymaps - 19 keymaps from LazyVim LSP section
[
  # 1. LSP Info
  { mode = "n"; key = "<leader>cl"; action = "<cmd>LspInfo<cr>"; desc = "Lsp info"; }
  
  # 2-6. Navigation
  { mode = "n"; key = "gd"; action = "<cmd>lua vim.lsp.buf.definition()<cr>"; desc = "Goto definition"; }
  { mode = "n"; key = "gr"; action = "<cmd>lua vim.lsp.buf.references()<cr>"; desc = "References"; }
  { mode = "n"; key = "gI"; action = "<cmd>lua vim.lsp.buf.implementation()<cr>"; desc = "Goto implementation"; }
  { mode = "n"; key = "gy"; action = "<cmd>lua vim.lsp.buf.type_definition()<cr>"; desc = "Goto type definition"; }
  { mode = "n"; key = "gD"; action = "<cmd>lua vim.lsp.buf.declaration()<cr>"; desc = "Goto declaration"; }
  
  # 7-9. Help and hover
  { mode = "n"; key = "K"; action = "<cmd>lua vim.lsp.buf.hover()<cr>"; desc = "Hover"; }
  { mode = "n"; key = "gK"; action = "<cmd>lua vim.lsp.buf.signature_help()<cr>"; desc = "Signature help"; }
  { mode = "i"; key = "<c-k>"; action = "<cmd>lua vim.lsp.buf.signature_help()<cr>"; desc = "Signature help"; }
  
  # 10-15. Code actions and refactoring
  { mode = ["n" "v"]; key = "<leader>ca"; action = "<cmd>lua vim.lsp.buf.code_action()<cr>"; desc = "Code action"; }
  { mode = ["n" "v"]; key = "<leader>cc"; action = "<cmd>lua vim.lsp.codelens.run()<cr>"; desc = "Run codelens"; }
  { mode = "n"; key = "<leader>cC"; action = "<cmd>lua vim.lsp.codelens.refresh()<cr>"; desc = "Refresh & display codelens"; }
  { mode = "n"; key = "<leader>cR"; action = "<cmd>lua vim.lsp.buf.rename()<cr>"; desc = "Rename"; }
  { mode = "n"; key = "<leader>cr"; action = "<cmd>lua vim.lsp.buf.rename()<cr>"; desc = "Rename"; }
  { mode = "n"; key = "<leader>cA"; action = "<cmd>lua vim.lsp.buf.code_action()<cr>"; desc = "Source action"; }
  
  # 16-19. Reference navigation
  { mode = "n"; key = "]]"; action = "<cmd>lua vim.lsp.buf.references()<cr>"; desc = "Next reference"; }
  { mode = "n"; key = "[["; action = "<cmd>lua vim.lsp.buf.references()<cr>"; desc = "Prev reference"; }
  { mode = "n"; key = "<a-n>"; action = "<cmd>lua vim.lsp.buf.references()<cr>"; desc = "Next reference"; }
  { mode = "n"; key = "<a-p>"; action = "<cmd>lua vim.lsp.buf.references()<cr>"; desc = "Prev reference"; }
]