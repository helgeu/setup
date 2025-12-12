{
  enableFormat = true;
  enableDAP = true;
  python.enable = true;
  lua.enable = true;
  nix.enable = true;
  markdown.enable = true;
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
      servers = ["omnisharp"];
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
