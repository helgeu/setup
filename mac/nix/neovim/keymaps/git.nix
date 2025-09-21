# Git-related keymaps
{ pkgs, ... }: {
  keymaps = [
    {
      key = "<leader>gg";
      action = ":LazyGit<CR>";
      mode = "n";
      options.desc = "Open LazyGit";
    }
    {
      key = "<leader>gb";
      action = ":Gitsigns toggle_current_line_blame<CR>";
      mode = "n";
      options.desc = "Toggle git blame";
    }
    {
      key = "<leader>gd";
      action = ":Gitsigns diffthis<CR>";
      mode = "n";
      options.desc = "Show git diff";
    }
  ];
}