# Diagnostics-related keymaps
{ pkgs, ... }: {
  keymaps = [
    {
      key = "[d";
      action = ":lua vim.diagnostic.goto_prev()<CR>";
      mode = "n";
      options.desc = "Previous diagnostic";
    }
    {
      key = "]d";
      action = ":lua vim.diagnostic.goto_next()<CR>";
      mode = "n";
      options.desc = "Next diagnostic";
    }
    {
      key = "<leader>de";
      action = ":lua vim.diagnostic.open_float()<CR>";
      mode = "n";
      options.desc = "Show diagnostic details";
    }
    {
      key = "<leader>dq";
      action = ":lua vim.diagnostic.setloclist()<CR>";
      mode = "n";
      options.desc = "Show diagnostic list";
    }
  ];
}