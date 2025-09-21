# Main Neovim configuration entry point
{pkgs, ...}: {
  programs.nixvim = {
    # Configuration modules
    imports = [
      # Core configuration
      (import ./neovim/options.nix { inherit pkgs; })
      (import ./neovim/autocmds.nix { inherit pkgs; })

      # UI and theme
      (import ./neovim/catppuccin.nix { inherit pkgs; })

      # Code intelligence
      (import ./neovim/lsp.nix { inherit pkgs; })
      (import ./neovim/diagnostics.nix { inherit pkgs; })
      (import ./neovim/completion.nix { inherit pkgs; })
      (import ./neovim/treesitter.nix { inherit pkgs; })

      # Language-specific
      (import ./neovim/languages/fsharp.nix { inherit pkgs; })
    ];
    
    config = {
      enable = true;
      viAlias = true;
      vimAlias = true;

      plugins = {
        #################
        # UI Navigation #
        #################
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

        which-key = {
          enable = true;
          # Using the new format as per which-key v3
          settings.register = [
            {
              prefix = "<leader>n";
              name = "Nix";
            }
            {
              prefix = "<leader>g";
              name = "Git";
            }
            {
              prefix = "<leader>u";
              name = "UI";
            }
            {
              prefix = "<leader>d";
              name = "Debug";
            }
          ];
        };
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

        ####################
        # Git Integration #
        ####################
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



        ######################
        # Debugging Support #
        ######################
        dap = {
          enable = true;
        };
        dap-ui = {
          enable = true;
        };

        #########################
        # Editor Enhancements #
        #########################
        nvim-autopairs = {
          enable = true;
          settings = {
            check_ts = true;  # Use treesitter for better pairing
          };
        };

        comment = {
          enable = true;
        };



        indent-blankline = {
          enable = true;
          settings = {
            scope = {
              enabled = true;
              show_start = true;
              show_end = true;
              highlight = "Function";  # Use existing highlight group
            };
            indent = {
              highlight = "LineNr";    # Use existing highlight group
            };
          };
        };
      };

      #############
      # Keymaps #
      #############
      keymaps = [
        # Nix-specific keymaps
        {
          key = "<leader>nf";
          action = ":lua vim.lsp.buf.format()<CR>";
          mode = "n";
          options.desc = "Format Nix file";
        }
        {
          key = "<leader>na";
          action = ":lua vim.lsp.buf.code_action()<CR>";
          mode = "n";
          options.desc = "Nix code actions";
        }
        {
          key = "<leader>nr";
          action = ":!nix run<CR>";
          mode = "n";
          options.desc = "Run nix project";
        }
        # General keymaps
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
        # Debugging keymaps
        {
          key = "<leader>db";
          action = ":DapToggleBreakpoint<CR>";
          mode = "n";
          options.desc = "Toggle breakpoint";
        }
        {
          key = "<leader>dc";
          action = ":DapContinue<CR>";
          mode = "n";
          options.desc = "Start/Continue debugging";
        }
        {
          key = "<leader>di";
          action = ":DapStepInto<CR>";
          mode = "n";
          options.desc = "Step into";
        }
        {
          key = "<leader>do";
          action = ":DapStepOver<CR>";
          mode = "n";
          options.desc = "Step over";
        }
        {
          key = "<leader>dO";
          action = ":DapStepOut<CR>";
          mode = "n";
          options.desc = "Step out";
        }
        {
          key = "<leader>dt";
          action = ":DapTerminate<CR>";
          mode = "n";
          options.desc = "Terminate debug session";
        }
      ];

      globals.mapleader = " ";
    };
  };
}