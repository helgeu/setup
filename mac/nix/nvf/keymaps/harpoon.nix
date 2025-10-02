# Harpoon Keymaps
# LazyVim keymaps for harpoon - 11 keymaps

[
  {
    mode = ["n"];
    key = "<leader>1";
    action = "<cmd>lua require('harpoon'):list():select(1)<cr>";
    desc = "Harpoon to File 1";
  }
  {
    mode = ["n"];
    key = "<leader>2";
    action = "<cmd>lua require('harpoon'):list():select(2)<cr>";
    desc = "Harpoon to File 2";
  }
  {
    mode = ["n"];
    key = "<leader>3";
    action = "<cmd>lua require('harpoon'):list():select(3)<cr>";
    desc = "Harpoon to File 3";
  }
  {
    mode = ["n"];
    key = "<leader>4";
    action = "<cmd>lua require('harpoon'):list():select(4)<cr>";
    desc = "Harpoon to File 4";
  }
  {
    mode = ["n"];
    key = "<leader>5";
    action = "<cmd>lua require('harpoon'):list():select(5)<cr>";
    desc = "Harpoon to File 5";
  }
  {
    mode = ["n"];
    key = "<leader>6";
    action = "<cmd>lua require('harpoon'):list():select(6)<cr>";
    desc = "Harpoon to File 6";
  }
  {
    mode = ["n"];
    key = "<leader>7";
    action = "<cmd>lua require('harpoon'):list():select(7)<cr>";
    desc = "Harpoon to File 7";
  }
  {
    mode = ["n"];
    key = "<leader>8";
    action = "<cmd>lua require('harpoon'):list():select(8)<cr>";
    desc = "Harpoon to File 8";
  }
  {
    mode = ["n"];
    key = "<leader>9";
    action = "<cmd>lua require('harpoon'):list():select(9)<cr>";
    desc = "Harpoon to File 9";
  }
  {
    mode = ["n"];
    key = "<leader>h";
    action = "<cmd>lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())<cr>";
    desc = "Harpoon Quick Menu";
  }
  {
    mode = ["n"];
    key = "<leader>H";
    action = "<cmd>lua require('harpoon'):list():add()<cr>";
    desc = "Harpoon File";
  }
]