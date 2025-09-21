{ pkgs, ... }: {
  config = {
    plugins = {
      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true; # Nix
          fsautocomplete = {    # F#
            enable = true;
            extraOptions = {
              AutomaticWorkspaceInit = true;
            };
          };
        };
      };

      cmp-nvim-lsp.enable = true;
    };
  };
}