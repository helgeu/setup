# Configure mini.nvim icons module
{ pkgs, ... }: {
  plugins.mini = {
    enable = true;
    modules.icons = {
      enable = true;
      setup = {
        preset = "default";
      };
    };
  };
}