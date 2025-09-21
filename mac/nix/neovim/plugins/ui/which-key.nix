# UI Enhancement plugins - Which-key menu and devicons
{ pkgs, ... }: {
  plugins = {
    # Icons for file types and folders
    web-devicons.enable = true;

    # Key binding menu and documentation
    which-key = {
      enable = true;
      settings.plugins.presets = {
        operators = true;
        motions = true;
        text_objects = true;
        windows = true;
        nav = true;
        z = true;
        g = true;
      };
      settings.icons = {
        breadcrumb = "»";
        separator = "➜";
        group = "+";
      };
      settings.window = {
        border = "single";
        position = "bottom";
        margin = { top = 1; right = 0; bottom = 1; left = 0; };
        padding = { top = 1; right = 2; bottom = 1; left = 2; };
      };
      settings.layout = {
        height = { min = 4; max = 25; };
        width = { min = 20; max = 50; };
        spacing = 3;
        align = "left";
      };
      settings.spec = [
        {
          mode = "n";
          prefix = "<leader>n";
          name = "+nix";
        }
        {
          mode = "n";
          prefix = "<leader>g";
          name = "+git";
        }
        {
          mode = "n";
          prefix = "<leader>u";
          name = "+ui";
        }
        {
          mode = "n";
          prefix = "<leader>d";
          name = "+debug";
        }
      ];
    };
  };
}