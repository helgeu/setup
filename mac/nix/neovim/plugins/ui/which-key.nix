# UI Enhancement plugins - Which-key menu and devicons
{ pkgs, ... }: {
  plugins = {
    # Icons for file types and folders
    web-devicons.enable = true;

    # Key binding menu and documentation
    which-key = {
      enable = true;
      settings = {
        plugins.presets = {
          operators = true;
          motions = true;
          text_objects = true;
          windows = true;
          nav = true;
          z = true;
          g = true;
        };
        icons = {
          breadcrumb = "»";
          separator = "➜";
          group = "+";
        };
        win = {
          border = "single";
          position = "bottom";
          margin = [ 1 0 1 0 ];  # top right bottom left
          padding = [ 1 2 ];  # [ vertical horizontal ]
        };
        layout = {
          height = { min = 4; max = 25; };
          width = { min = 20; max = 50; };
          spacing = 3;
          align = "left";
        };
        spec = [
          { mode = "n"; prefix = "<leader>n"; name = "+nix"; }

          { mode = "n"; prefix = "<leader>g"; name = "+git"; }

          { mode = "n"; prefix = "<leader>u"; name = "+ui"; }

          {
            mode = "n";
            prefix = "<leader>f";
            name = "+lsp";
            bindings = {
              s = { desc = "Signature help"; };
              r = { desc = "Rename symbol"; };
              a = { desc = "Code actions"; };
              d = { desc = "Go to definition"; };
              i = { desc = "Go to implementation"; };
              t = { desc = "Type definition"; };
              h = { desc = "Hover information"; };
              u = { desc = "Find references"; };
            };
          }

          { mode = "n"; prefix = "<leader>d"; name = "+debug"; }
        ];
      };
    };
  };
}