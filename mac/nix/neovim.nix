{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "mocha"; # Dark theme variant
      };
    };

    plugins = {
      lsp = {
        enable = false;
      };
    };
  };
}
