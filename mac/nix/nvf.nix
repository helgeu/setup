{ pkgs, libs, ... }:
{
  programs.nvf = {
    enable = true;
    # Set Neovim from NVF as system default editor (sets EDITOR in sessionVariables)
    defaultEditor = true;
    settings = {
      vim = {

  # snacks-nvim settings are in nvf/snacks-nvim.nix
  utility = {
    snacks-nvim = import ./nvf/snacks-nvim.nix;
  };

        # luaConfigPost = ''
        #   vim.opt.tabstop = 2
        #   vim.opt.shiftwidth = 2
        #   vim.opt.expandtab = true
        #   vim.opt.fillchars = { eob = " "}
        #   vim.opt.autoindent = false
        #   vim.opt.smartindent = false
        #   vim.opt.smarttab = true
        #   vim.opt.scrolloff = 20;
        # '';
        theme = {
          enable = true;
          name = "tokyonight";
          style = "storm";

        };

        #      guiFont = "FiraCode Nerd Font Mono:h14";
        #guiFont = "MesloLGS NF:h14";

        statusline.lualine.enable = true;

        autocomplete.nvim-cmp.enable = true;

        lsp = import ./nvf/lsp.nix;

        debugger = import ./nvf/debugger.nix;

        binds = import ./nvf/binds.nix;

        # Custom keymaps following LazyVim patterns
        keymaps = import ./nvf/keymaps;

        # Set leader key early (required for leader-based keymaps)
        globals.mapleader = " ";
        globals.maplocalleader = "\\";

        # notify = {
        #   nvim-notify.enable = false;
        # };

        projects = {
          project-nvim.enable = false;
        };

        ui = {
          #borders.enable = false;
          noice.enable = true;
          colorizer.enable = true;
          #modes-nvim.enable = false; # the theme looks terrible with catppuccin

          breadcrumbs = {
            enable = false;
            navbuddy.enable = false;
          };
          fastaction.enable = true;
        };

        visuals = {
          # nvim-scrollbar.enable = false;
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          #cinnamon-nvim.enable = true;
          fidget-nvim.enable = false;

          highlight-undo.enable = true;
          #indent-blankline.enable = true;

          # Fun
          cellular-automaton.enable = false;
        };

        autopairs.nvim-autopairs.enable = true;

        languages = import ./nvf/languages.nix;
      };
    };
  };
}
