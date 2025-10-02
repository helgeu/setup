# Sidekick.nvim Keymaps
# LazyVim keymaps for sidekick.nvim - 6 keymaps

[
  {
    mode = ["n" "v"];
    key = "<leader>a";
    action = "";
    desc = "+ai";
  }
  {
    mode = ["n"];
    key = "<leader>aa";
    action = "<cmd>lua require('sidekick').toggle()<cr>";
    desc = "Sidekick Toggle CLI";
  }
  {
    mode = ["n" "v"];
    key = "<leader>ap";
    action = "<cmd>lua require('sidekick').pick_prompt()<cr>";
    desc = "Sidekick Select Prompt";
  }
  {
    mode = ["n"];
    key = "<leader>as";
    action = "<cmd>lua require('sidekick').select_cli()<cr>";
    desc = "Sidekick Select CLI";
  }
  {
    mode = ["v"];
    key = "<leader>as";
    action = "<cmd>lua require('sidekick').send_visual_selection()<cr>";
    desc = "Sidekick Send Visual Selection";
  }
  {
    mode = ["n" "i" "t" "x"];
    key = "<c-.>";
    action = "<cmd>lua require('sidekick').switch_focus()<cr>";
    desc = "Sidekick Switch Focus";
  }
]