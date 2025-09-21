# Nix-specific keymaps
{ pkgs, ... }: {
  keymaps = [
    {
      key = "<leader>nf";
      action = ":lua vim.lsp.buf.format()<CR>";
      mode = "n";
      options.desc = "Format Nix file";
    }
    {
      key = "<leader>na";
      action = ":lua vim.lsp.buf.code_action()<CR>";
      mode = "n";
      options.desc = "Nix code actions";
    }
    {
      key = "<leader>nr";
      action = ":!nix run<CR>";
      mode = "n";
      options.desc = "Run nix project";
    }
  ];
}