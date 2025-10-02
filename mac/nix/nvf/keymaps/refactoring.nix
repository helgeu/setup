# Refactoring.nvim Keymaps
# LazyVim keymaps for refactoring.nvim - 10 keymaps

[
  {
    mode = ["n" "x"];
    key = "<leader>r";
    action = "";
    desc = "+refactor";
  }
  {
    mode = ["n" "x"];
    key = "<leader>rb";
    action = "<cmd>lua require('refactoring').refactor('Extract Block')<cr>";
    desc = "Extract Block";
  }
  {
    mode = ["n"];
    key = "<leader>rc";
    action = "<cmd>lua require('refactoring').debug.cleanup({})<cr>";
    desc = "Debug Cleanup";
  }
  {
    mode = ["n" "x"];
    key = "<leader>rf";
    action = "<cmd>lua require('refactoring').refactor('Extract Function')<cr>";
    desc = "Extract Function";
  }
  {
    mode = ["n" "x"];
    key = "<leader>rF";
    action = "<cmd>lua require('refactoring').refactor('Extract Function To File')<cr>";
    desc = "Extract Function To File";
  }
  {
    mode = ["n" "x"];
    key = "<leader>ri";
    action = "<cmd>lua require('refactoring').refactor('Inline Variable')<cr>";
    desc = "Inline Variable";
  }
  {
    mode = ["n" "x"];
    key = "<leader>rp";
    action = "<cmd>lua require('refactoring').debug.print_var({})<cr>";
    desc = "Debug Print Variable";
  }
  {
    mode = ["n"];
    key = "<leader>rP";
    action = "<cmd>lua require('refactoring').debug.print_var({ normal = true })<cr>";
    desc = "Debug Print";
  }
  {
    mode = ["n" "x"];
    key = "<leader>rs";
    action = "<cmd>lua require('refactoring').select_refactor()<cr>";
    desc = "Refactor";
  }
  {
    mode = ["n" "x"];
    key = "<leader>rx";
    action = "<cmd>lua require('refactoring').refactor('Extract Variable')<cr>";
    desc = "Extract Variable";
  }
]