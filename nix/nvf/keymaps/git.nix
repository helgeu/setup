# Git keymaps - Snacks git browse
# Installed: snacks-nvim
# Removed: mini.diff, octo
[
  # === Which-key group ===
  { mode = "n"; key = "<leader>g"; action = ""; desc = "+git"; }

  # === Snacks git browse ===
  { key = "<leader>gg"; action = "<cmd>lua Snacks.gitbrowse()<cr>"; mode = ["n"]; desc = "Git Browse (Root Dir)"; }
  { key = "<leader>gG"; action = "<cmd>lua Snacks.gitbrowse({ cwd = vim.uv.cwd() })<cr>"; mode = ["n"]; desc = "Git Browse (cwd)"; }
]
