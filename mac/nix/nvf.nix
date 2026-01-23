{
  pkgs,
  libs,
  ...
}: {
  programs.nvf = {
    enable = true;
    # Set Neovim from NVF as system default editor (sets EDITOR in sessionVariables)
    defaultEditor = true;

    # need these modules in vim to make dadbod work?
    #Plug 'tpope/vim-dadbod'
    #Plug 'kristijanhusak/vim-dadbod-ui'
    #Plug 'kristijanhusak/vim-dadbod-completion' "Optional

    settings = {
      vim = {
        # Extra plugins (see nvf/extraplugins/)
        extraPlugins = import ./nvf/extraplugins {inherit pkgs;};

        # snacks-nvim settings are in nvf/snacks-nvim.nix
        utility = {
          snacks-nvim = import ./nvf/snacks-nvim.nix;
        };
        treesitter.enable = true;
        clipboard = {
          registers = "unnamedplus";
          enable = true;
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
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;

        assistant.copilot = import ./nvf/copilot.nix {inherit pkgs;};

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
        tabline.nvimBufferline = {
          enable = true;
          #mode = "buffers";
          setupOpts = {
            options = {
              show_buffer_close_icons = true;
              show_close_icon = false;
              show_filename_only = true;
              numbers = "none";
              modified_icon = "●";
              show_modified_icon = {
                __raw = ''
                  function(buf)
                              return buf.modified
                            end'';
              };
              show_tab_indicators = false;
              separator_style = "thin";
              clipboard = "unnamedplus";
              diagnostics = false;
              indicator = {
                style = "none";
              };
            };
          };
          # Buffer Navigation
          mappings = {
            cycleNext = "<leader>bl";
            cyclePrevious = "<leader>bh";
            closeCurrent = "<leader>bx";
            pick = "<leader>bp";
            # ReOrder the tabs
            moveNext = "<leader>me";
            movePrevious = "<leader>mq";
          };
        };
      };
    };
  };
}
