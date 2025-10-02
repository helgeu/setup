# Edgy UI Keymaps
# Part of lazyvim.plugins.extras.ui.edgy
[
  # edgy.nvim keymaps
  {
    key = "<leader>ue";
    action = "<cmd>lua require('edgy').toggle()<cr>";
    mode = ["n"];
    options = {
      desc = "Edgy Toggle";
    };
  }
  {
    key = "<leader>uE";
    action = "<cmd>lua require('edgy').select_window()<cr>";
    mode = ["n"];
    options = {
      desc = "Edgy Select Window";
    };
  }
]