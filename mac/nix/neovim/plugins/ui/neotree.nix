{pkgs, ...}: {
  plugins = {
      neo-tree = {
        enable = true;
        closeIfLastWindow = true;
        window.mappings = {
          "<space>" = "toggle_node";
          "o" = "open";
        };
      };
    };
}