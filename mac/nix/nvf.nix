{ pkgs, libs, ... }:
{
  programs.nvf = {
    enable = true;
    # Set Neovim from NVF as system default editor (sets EDITOR in sessionVariables)
    defaultEditor = true;
    settings = {
      vim = {

        utility = {
          snacks-nvim = {
            enable = true;
            setupOpts = {
              bigfile.enable = true;
              #dashboard.enable = true;
              explorer.enable = true;
              indent.enable = true;
              input.enable = true;
              picker.enable = true;
              notifier.enable = true;
              project.enable = true;
              quickfile.enable = true;
              scope.enable = true;
              statuscolumn.enable = true;
              words.enable = true;
            };
          };
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

        lsp = {
          enable = true;
          formatOnSave = true;
          #inlayHints.enable = true; this does not show errors and warnings - only types?
          lspkind.enable = true;
          lspconfig.enable = true;
          lightbulb.enable = false;
          lspsaga.enable = false;
          trouble.enable = false;
          lspSignature.enable = true;
          otter-nvim.enable = false;
          nvim-docs-view.enable = false;
        };

        debugger = {
          nvim-dap = {
            enable = true;
            ui.enable = true;
          };
        };

        binds = {
          whichKey.enable = true;
          cheatsheet.enable = true;
        };

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

        languages = {
          enableFormat = true;
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
        };
      };
    };
  };
}
