# Chezmoi Utility Keymaps
# Part of lazyvim.plugins.extras.util.chezmoi
[
  # chezmoi.nvim keymaps
  {
    key = "<leader>sz";
    action = "<cmd>lua require('telescope').extensions.chezmoi.find_files()<cr>";
    mode = ["n"];
    desc = "Chezmoi";
  }
]