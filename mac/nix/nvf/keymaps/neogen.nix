# Neogen Keymaps
# LazyVim keymaps for neogen - 1 keymap

[
  {
    mode = ["n"];
    key = "<leader>cn";
    action = "<cmd>lua require('neogen').generate()<cr>";
    desc = "Generate Annotations (Neogen)";
  }
]