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
      type = "fantomas";
    };
    lsp = {
      enable = true;
      server = "fsautocomplete";
    };
    treesitter = {
      enable = true;
    };
  };
  csharp = {
    enable = true;
    lsp = {
      enable = true;
      server = "omnisharp";
    };
    treesitter = {
      enable = true;
    };
  };
  enableTreesitter = true;
}
