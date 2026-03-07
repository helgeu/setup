# Tools keymaps - LSP
# Installed: lspconfig
# Removed: mason, ansible, markdown-preview, venv-select, vimtex, kulala, overseer, persistence, mini.files, sidekick
[
  # === Which-key group ===
  { mode = "n"; key = "<leader>c"; action = ""; desc = "+code"; }

  # === LSP ===
  { mode = "n"; key = "<leader>cl"; action = "<cmd>LspInfo<cr>"; desc = "Lsp info"; }
  { mode = "n"; key = "gd"; action = "<cmd>lua vim.lsp.buf.definition()<cr>"; desc = "Goto definition"; }
  { mode = "n"; key = "gr"; action = "<cmd>lua vim.lsp.buf.references()<cr>"; desc = "References"; }
  { mode = "n"; key = "gI"; action = "<cmd>lua vim.lsp.buf.implementation()<cr>"; desc = "Goto implementation"; }
  { mode = "n"; key = "gy"; action = "<cmd>lua vim.lsp.buf.type_definition()<cr>"; desc = "Goto type definition"; }
  { mode = "n"; key = "gD"; action = "<cmd>lua vim.lsp.buf.declaration()<cr>"; desc = "Goto declaration"; }
  { mode = "n"; key = "K"; action = "<cmd>lua vim.lsp.buf.hover()<cr>"; desc = "Hover"; }
  { mode = "n"; key = "gK"; action = "<cmd>lua vim.lsp.buf.signature_help()<cr>"; desc = "Signature help"; }
  { mode = "i"; key = "<c-k>"; action = "<cmd>lua vim.lsp.buf.signature_help()<cr>"; desc = "Signature help"; }
  { mode = ["n" "v"]; key = "<leader>ca"; action = "<cmd>lua vim.lsp.buf.code_action()<cr>"; desc = "Code action"; }
  { mode = ["n" "v"]; key = "<leader>cc"; action = "<cmd>lua vim.lsp.codelens.run()<cr>"; desc = "Run codelens"; }
  { mode = "n"; key = "<leader>cC"; action = "<cmd>lua vim.lsp.codelens.refresh()<cr>"; desc = "Refresh & display codelens"; }
  { mode = "n"; key = "<leader>cr"; action = "<cmd>lua vim.lsp.buf.rename()<cr>"; desc = "Rename"; }
]
