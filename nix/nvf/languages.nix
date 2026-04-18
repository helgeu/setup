{
  enableFormat = true;
  enableDAP = true;
  python.enable = true;
  lua.enable = true;
  nix.enable = true;
  markdown.enable = true;
  ts.enable = true;
  bash.enable = true;
  css.enable = true;
  yaml.enable = true;
  fsharp = {
    enable = true;
    format = {
      enable = true;
      type = ["fantomas"];
    };
    lsp = {
      enable = true;
      servers = ["fsautocomplete"];
    };
    treesitter = {
      enable = true;
    };
  };
  csharp = {
    enable = true;
    lsp = {
      enable = true;
      # Same pkgs.roslyn-ls binary as Claude (see lsp-servers.nix).
      servers = ["roslyn_ls"];
    };
    treesitter = {
      enable = true;
    };
  };
  # powershell = {
  #   enable = true;
  # };
  enableTreesitter = true;
}
