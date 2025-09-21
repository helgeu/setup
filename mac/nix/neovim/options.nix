{ pkgs, ... }: {
  config.opts = {
    number = true;
    relativenumber = true;
    shiftwidth = 4;
    expandtab = true;
    tabstop = 4;
    termguicolors = true;
  };
}