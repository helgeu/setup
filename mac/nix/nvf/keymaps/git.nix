# Git keymaps - git tools and GitHub integration
# Consolidated from: gitui.nix, octo.nix, mini-diff.nix
[
  # === GitUI / Snacks git browse ===
  { key = "<leader>gg"; action = "<cmd>lua Snacks.gitbrowse()<cr>"; mode = ["n"]; desc = "GitUi (Root Dir)"; }
  { key = "<leader>gG"; action = "<cmd>lua Snacks.gitbrowse({ cwd = vim.uv.cwd() })<cr>"; mode = ["n"]; desc = "GitUi (cwd)"; }

  # === Mini.diff ===
  { mode = ["n"]; key = "<leader>go"; action = "<cmd>lua require('mini.diff').toggle_overlay()<cr>"; desc = "Toggle mini.diff overlay"; }

  # === Octo (GitHub) ===
  { key = "<leader>gi"; action = "<cmd>Octo issue list<cr>"; mode = ["n"]; desc = "List Issues (Octo)"; }
  { key = "<leader>gI"; action = "<cmd>Octo issue search<cr>"; mode = ["n"]; desc = "Search Issues (Octo)"; }
  { key = "<leader>gp"; action = "<cmd>Octo pr list<cr>"; mode = ["n"]; desc = "List PRs (Octo)"; }
  { key = "<leader>gP"; action = "<cmd>Octo pr search<cr>"; mode = ["n"]; desc = "Search PRs (Octo)"; }
  { key = "<leader>gr"; action = "<cmd>Octo repo list<cr>"; mode = ["n"]; desc = "List Repos (Octo)"; }
  { key = "<leader>gO"; action = "<cmd>Octo search<cr>"; mode = ["n"]; desc = "Octo Search"; }

  # Octo localleader bindings (for PR/issue buffers)
  { key = "<localleader>a"; action = "+assignee (Octo)"; mode = ["n"]; desc = "+assignee (Octo)"; }
  { key = "<localleader>c"; action = "+comment/code (Octo)"; mode = ["n"]; desc = "+comment/code (Octo)"; }
  { key = "<localleader>g"; action = "+goto_issue (Octo)"; mode = ["n"]; desc = "+goto_issue (Octo)"; }
  { key = "<localleader>i"; action = "+issue (Octo)"; mode = ["n"]; desc = "+issue (Octo)"; }
  { key = "<localleader>l"; action = "+label (Octo)"; mode = ["n"]; desc = "+label (Octo)"; }
  { key = "<localleader>p"; action = "+pr (Octo)"; mode = ["n"]; desc = "+pr (Octo)"; }
  { key = "<localleader>pr"; action = "+rebase (Octo)"; mode = ["n"]; desc = "+rebase (Octo)"; }
  { key = "<localleader>ps"; action = "+squash (Octo)"; mode = ["n"]; desc = "+squash (Octo)"; }
  { key = "<localleader>r"; action = "+react (Octo)"; mode = ["n"]; desc = "+react (Octo)"; }
  { key = "<localleader>v"; action = "+review (Octo)"; mode = ["n"]; desc = "+review (Octo)"; }
]
