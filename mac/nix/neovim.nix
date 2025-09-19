{ pkgs, ... }: {
  programs.nixvim = {
    config = {
      enable = true;
      viAlias = true;
      vimAlias = true;

      colorschemes.catppuccin = {
        enable = true;
        settings.flavour = "mocha";
      };

      opts = {
        number = true;
        relativenumber = true;
        shiftwidth = 4;
        expandtab = true;
        tabstop = 4;
        termguicolors = true;
      };

      plugins = {
        lsp = {
          enable = true;
          servers.omnisharp = {
            enable = true;
            filetypes = [ "cs" "csx" "omnisharp" ];
          };
        };

        treesitter = {
          enable = true;
          grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [ c-sharp ];
        };

        telescope = {
          enable = true;
          keymaps = {
            "<leader>ff" = "find_files";
            "<leader>fg" = "live_grep";
            "<leader>fb" = "buffers";
            "<leader>fh" = "help_tags";
          };
        };

        neo-tree = {
          enable = true;
          closeIfLastWindow = true;
          window.mappings = {
            "<space>" = "toggle_node";
            "o" = "open";
          };
        };

        which-key.enable = true;
        web-devicons.enable = true;

        # Status line with code context
        lualine = {
          enable = true;
          settings.sections = {
            lualine_c = [
              "filename"
              "require('nvim-navic').get_location()"
            ];
          };
        };

        # Code context in statusline
        navic = {
          enable = true;
          settings = {
            lsp.auto_attach = true;     # Automatically attach to LSP
            highlight = true;          # Highlight the context path
          };
        };

        # Git integration
        gitsigns = {
          enable = true;
          settings = {
            signs = {
              add.text = "+";
              change.text = "~";
              delete.text = "_";
              topdelete.text = "‾";
              changedelete.text = "~";
            };
            current_line_blame = true;  # Git blame for current line
            current_line_blame_opts = {
              delay = 300;
            };
          };
        };

        fugitive.enable = true;  # Classic git commands in vim

        # Lazygit integration
        lazygit = {
          enable = true;
        };

        # Completion
        cmp = {
          enable = true;
          settings = {
            mapping = {
              "<C-Space>" = "cmp.mapping.complete()";
              "<C-d>" = "cmp.mapping.scroll_docs(-4)";
              "<C-f>" = "cmp.mapping.scroll_docs(4)";
              "<C-n>" = "cmp.mapping.select_next_item()";
              "<C-p>" = "cmp.mapping.select_prev_item()";
              "<CR>" = "cmp.mapping.confirm({ select = true })";
              "<Tab>" = "cmp.mapping.select_next_item()";
              "<S-Tab>" = "cmp.mapping.select_prev_item()";
            };
            sources = [
              { name = "nvim_lsp"; }
              { name = "luasnip"; }
              { name = "buffer"; }
              { name = "path"; }
            ];
            snippet.expand = "luasnip";
          };
        };

        # LSP completion source
        cmp-nvim-lsp.enable = true;
        
        # Buffer completion source
        cmp-buffer.enable = true;
        
        # Path completion source
        cmp-path.enable = true;

        # Snippet engine
        luasnip = {
          enable = true;
        };

        # Snippet completion source
        cmp_luasnip.enable = true;
      };

      keymaps = [
        {
          key = "<C-n>";
          action = ":Neotree toggle<CR>";
          mode = "n";
        }
        {
          key = "<leader>e";
          action = ":Neotree focus<CR>";
          mode = "n";
        }
        # Git keymaps
        {
          key = "<leader>gg";
          action = ":LazyGit<CR>";
          mode = "n";
          options.desc = "Open LazyGit";
        }
        {
          key = "<leader>gb";
          action = ":Gitsigns toggle_current_line_blame<CR>";
          mode = "n";
          options.desc = "Toggle git blame";
        }
        {
          key = "<leader>gd";
          action = ":Gitsigns diffthis<CR>";
          mode = "n";
          options.desc = "Show git diff";
        }
        {
          key = "]c";
          action = ":Gitsigns next_hunk<CR>";
          mode = "n";
          options.desc = "Next git change";
        }
        {
          key = "[c";
          action = ":Gitsigns prev_hunk<CR>";
          mode = "n";
          options.desc = "Previous git change";
        }
      ];

      globals.mapleader = " ";
    };
  };
}