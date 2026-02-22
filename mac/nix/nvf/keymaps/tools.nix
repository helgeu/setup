# Tools keymaps - language-specific, utilities, sessions
# Consolidated from: lsp.nix, mason.nix, ansible.nix, markdown.nix, python-venv.nix, sql.nix, tex.nix, kulala.nix, chezmoi.nix, overseer.nix, persistence.nix, mini-files.nix, sidekick.nix, adoboards.nix
[
  # === Which-key groups ===
  { mode = "n"; key = "<leader>c"; action = ""; desc = "+code"; }
  { mode = "n"; key = "<leader>o"; action = ""; desc = "+overseer"; }

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
  { mode = "n"; key = "]]"; action = "<cmd>lua vim.lsp.buf.references()<cr>"; desc = "Next reference"; }
  { mode = "n"; key = "[["; action = "<cmd>lua vim.lsp.buf.references()<cr>"; desc = "Prev reference"; }
  { mode = "n"; key = "<a-n>"; action = "<cmd>lua vim.lsp.buf.references()<cr>"; desc = "Next reference"; }
  { mode = "n"; key = "<a-p>"; action = "<cmd>lua vim.lsp.buf.references()<cr>"; desc = "Prev reference"; }

  # === Mason ===
  { mode = ["n"]; key = "<leader>cm"; action = "<cmd>Mason<cr>"; desc = "Mason"; }

  # === Ansible ===
  { key = "<leader>ta"; action = "<cmd>lua require('ansible').run()<cr>"; mode = ["n"]; desc = "Ansible Run Playbook/Role"; }

  # === Markdown ===
  { key = "<leader>cp"; action = "<cmd>MarkdownPreview<cr>"; mode = ["n"]; desc = "Markdown Preview"; }

  # === Python VirtualEnv ===
  { key = "<leader>cv"; action = "<cmd>VenvSelect<cr>"; mode = ["n"]; desc = "Select VirtualEnv"; }

  # === SQL (dadbod) ===
  { key = "<leader>D"; action = "<cmd>DBUI<cr>"; mode = ["n"]; desc = "Toggle DBUI"; }

  # === TeX (vimtex) ===
  { key = "<localLeader>l"; action = "+vimtex"; mode = ["n"]; desc = "+vimtex"; }

  # === Kulala (REST) ===
  { key = "<leader>R"; action = "+Rest"; mode = ["n"]; desc = "+Rest"; }
  { key = "<leader>Rb"; action = "<cmd>lua require('kulala').scratchpad()<cr>"; mode = ["n"]; desc = "Open scratchpad"; }
  { key = "<leader>Rc"; action = "<cmd>lua require('kulala').copy()<cr>"; mode = ["n"]; desc = "Copy as cURL"; }
  { key = "<leader>RC"; action = "<cmd>lua require('kulala').from_curl()<cr>"; mode = ["n"]; desc = "Paste from curl"; }
  { key = "<leader>Rg"; action = "<cmd>lua require('kulala').download_graphql_schema()<cr>"; mode = ["n"]; desc = "Download GraphQL schema"; }
  { key = "<leader>Ri"; action = "<cmd>lua require('kulala').inspect()<cr>"; mode = ["n"]; desc = "Inspect current request"; }
  { key = "<leader>Rn"; action = "<cmd>lua require('kulala').jump_next()<cr>"; mode = ["n"]; desc = "Jump to next request"; }
  { key = "<leader>Rp"; action = "<cmd>lua require('kulala').jump_prev()<cr>"; mode = ["n"]; desc = "Jump to previous request"; }
  { key = "<leader>Rq"; action = "<cmd>lua require('kulala').close()<cr>"; mode = ["n"]; desc = "Close window"; }
  { key = "<leader>Rr"; action = "<cmd>lua require('kulala').replay()<cr>"; mode = ["n"]; desc = "Replay the last request"; }
  { key = "<leader>Rs"; action = "<cmd>lua require('kulala').run()<cr>"; mode = ["n"]; desc = "Send the request"; }
  { key = "<leader>RS"; action = "<cmd>lua require('kulala').show_stats()<cr>"; mode = ["n"]; desc = "Show stats"; }
  { key = "<leader>Rt"; action = "<cmd>lua require('kulala').toggle_view()<cr>"; mode = ["n"]; desc = "Toggle headers/body"; }

  # === Chezmoi ===
  { key = "<leader>sz"; action = "<cmd>lua require('telescope').extensions.chezmoi.find_files()<cr>"; mode = ["n"]; desc = "Chezmoi"; }

  # === Overseer (task runner) ===
  { mode = ["n"]; key = "<leader>ob"; action = "<cmd>OverseerBuild<cr>"; desc = "Task builder"; }
  { mode = ["n"]; key = "<leader>oc"; action = "<cmd>OverseerClearCache<cr>"; desc = "Clear cache"; }
  { mode = ["n"]; key = "<leader>oi"; action = "<cmd>OverseerInfo<cr>"; desc = "Overseer Info"; }
  { mode = ["n"]; key = "<leader>oo"; action = "<cmd>OverseerRun<cr>"; desc = "Run task"; }
  { mode = ["n"]; key = "<leader>oq"; action = "<cmd>OverseerQuickAction<cr>"; desc = "Action recent task"; }
  { mode = ["n"]; key = "<leader>ot"; action = "<cmd>OverseerTaskAction<cr>"; desc = "Task action"; }
  { mode = ["n"]; key = "<leader>ow"; action = "<cmd>OverseerToggle<cr>"; desc = "Task list"; }

  # === Persistence (sessions) ===
  { mode = ["n"]; key = "<leader>qd"; action = "<cmd>lua require('persistence').stop()<cr>"; desc = "Don't Save Current Session"; }
  { mode = ["n"]; key = "<leader>ql"; action = "<cmd>lua require('persistence').load({ last = true })<cr>"; desc = "Restore Last Session"; }
  { mode = ["n"]; key = "<leader>qs"; action = "<cmd>lua require('persistence').load()<cr>"; desc = "Restore Session"; }
  { mode = ["n"]; key = "<leader>qS"; action = "<cmd>lua require('persistence').select()<cr>"; desc = "Select Session"; }

  # === Mini.files ===
  { mode = ["n"]; key = "<leader>fm"; action = "<cmd>lua require('mini.files').open(vim.api.nvim_buf_get_name(0), true)<cr>"; desc = "Open mini.files (Directory of Current File)"; }
  { mode = ["n"]; key = "<leader>fM"; action = "<cmd>lua require('mini.files').open(vim.uv.cwd(), true)<cr>"; desc = "Open mini.files (cwd)"; }

  # === Sidekick (AI) ===
  { mode = ["n" "v"]; key = "<leader>a"; action = ""; desc = "+ai"; }
  { mode = ["n"]; key = "<leader>aa"; action = "<cmd>lua require('sidekick').toggle()<cr>"; desc = "Sidekick Toggle CLI"; }
  { mode = ["n" "v"]; key = "<leader>ap"; action = "<cmd>lua require('sidekick').pick_prompt()<cr>"; desc = "Sidekick Select Prompt"; }
  { mode = ["n"]; key = "<leader>as"; action = "<cmd>lua require('sidekick').select_cli()<cr>"; desc = "Sidekick Select CLI"; }
  { mode = ["v"]; key = "<leader>as"; action = "<cmd>lua require('sidekick').send_visual_selection()<cr>"; desc = "Sidekick Send Visual Selection"; }
  { mode = ["n" "i" "t" "x"]; key = "<c-.>"; action = "<cmd>lua require('sidekick').switch_focus()<cr>"; desc = "Sidekick Switch Focus"; }

  # === AdoBoards (Azure DevOps) ===
  { mode = "n"; key = "<leader>ab"; action = "<cmd>AdoBoards<cr>"; desc = "AdoBoards (horizontal split)"; }
  { mode = "n"; key = "<leader>aB"; action = "<cmd>AdoBoardsFullscreen<cr>"; desc = "AdoBoards (fullscreen)"; }
  { mode = "n"; key = "<leader>av"; action = "<cmd>AdoBoardsV<cr>"; desc = "AdoBoards (vertical split)"; }
  { mode = "n"; key = "<leader>at"; action = "<cmd>AdoBoardsTab<cr>"; desc = "AdoBoards (new tab)"; }
]
