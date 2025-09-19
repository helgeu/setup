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

      autoCmd = [
        {
          event = "FileType";
          pattern = "nix";
          command = "setlocal tabstop=2 shiftwidth=2";  # Nix files typically use 2 spaces
        }
        {
          event = "BufWritePre";
          pattern = "*.nix";
          command = "lua vim.lsp.buf.format()";  # Format Nix files on save
        }
        {
          event = "FileType";
          pattern = [ "fsharp" "fs" "fsi" "fsx" ];
          command = "setlocal expandtab tabstop=4 shiftwidth=4";  # F# convention
        }
        {
          event = [ "BufNewFile" "BufRead" ];
          pattern = [ "*.fs" "*.fsx" "*.fsi" ];
          command = "setfiletype fsharp";  # Ensure proper filetype detection
        }
        {
          event = "BufWritePre";
          pattern = [ "*.fs" "*.fsx" "*.fsi" ];
          command = "lua vim.lsp.buf.format()";  # Format F# files on save
        }
      ];

      # Global Neovim settings for diagnostics
      extraConfigLua = ''
        -- F# specific setup
        vim.api.nvim_create_autocmd("FileType", {
          pattern = { "fsharp", "fs", "fsi", "fsx" },
          callback = function()
            -- LSP mappings
            local opts = { noremap = true, silent = true, buffer = true }
            vim.keymap.set("n", "<leader>fs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
            vim.keymap.set("n", "<leader>fr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
            vim.keymap.set("n", "<leader>fa", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
            vim.keymap.set("n", "<leader>fd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
            vim.keymap.set("n", "<leader>fi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
            vim.keymap.set("n", "<leader>ft", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
            vim.keymap.set("n", "<leader>fh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
            vim.keymap.set("n", "<leader>fu", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
            vim.keymap.set("n", "<leader>ff", "<cmd>lua vim.lsp.buf.format()<CR>", opts)

            -- F# Interactive (REPL) mappings
            vim.keymap.set("n", "<leader>fsi", "<cmd>split term://dotnet fsi<CR>", opts)
            vim.keymap.set("v", "<leader>fse", ":'<,'>w !dotnet fsi<CR>", opts)
            vim.keymap.set("n", "<leader>fsl", "<cmd>. w !dotnet fsi<CR>", opts)
          end
        })

        -- Configure diagnostics
        vim.diagnostic.config({
          virtual_text = {
            format = function(diagnostic)
              if diagnostic.message:find("git%-blame") then
                return nil
              end
              return diagnostic.message
            end,
          },
          signs = true,
          underline = true,
          update_in_insert = false,
          severity_sort = true,
        })

        -- Override LSP handlers
        local old_handler = vim.lsp.handlers["textDocument/publishDiagnostics"]
        vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
          local filtered = {}
          for _, diagnostic in ipairs(result.diagnostics) do
            if not diagnostic.message:find("git%-blame") then
              table.insert(filtered, diagnostic)
            end
          end
          result.diagnostics = filtered
          return old_handler(err, result, ctx, config)
        end
      '';

      plugins = {
        lsp = {
          enable = true;
          servers = {
            omnisharp = {
              enable = true;
              filetypes = [ "cs" "csx" "omnisharp" ];
            };
            # LSP configuration for F# using Ionide
            fsautocomplete = {
              enable = true;
              cmd = [ "${pkgs.vscode-extensions.ionide.ionide-fsharp}/share/vscode/extensions/ionide.ionide-fsharp/fsac/fsautocomplete" ];
              filetypes = [ "fsharp" "fs" "fsi" "fsx" ];
              extraOptions = {
                capabilities = {
                  definitionProvider = true;
                  documentHighlightProvider = true;
                  completionProvider = {
                    resolveProvider = true;
                    triggerCharacters = [ "." ];
                  };
                  signatureHelpProvider = {
                    triggerCharacters = [ "(" " " ];
                  };
                  documentSymbolProvider = true;
                  workspaceSymbolProvider = true;
                  codeActionProvider = true;
                  codeLensProvider = {
                    resolveProvider = true;
                  };
                  documentFormattingProvider = true;
                  hoverProvider = true;
                  referencesProvider = true;
                };
                init_options = {
                  automaticWorkspaceInit = true;
                  workspaceModePeekDeepLevel = 4;
                  externalAutocomplete = false;
                  lineLens = {
                    enabled = true;
                    prefix = "→ ";
                  };
                  inlayHints = {
                    enabled = true;
                    typeAnnotations = true;
                    parameterNames = true;
                    disableLongTooltip = false;
                  };
                  fsac = {
                    dotnetRoot = "${pkgs.dotnet-sdk}";
                    fsiExtraParameters = [ "--readline-" ];
                  };
                };
              };
            };
            nil_ls = {
              enable = true;
              extraOptions = {
                command = [ "nil" ];
                settings = {
                  nil = {
                    formatting = {
                      command = [ "nixpkgs-fmt" ];
                    };
                    nix = {
                      maxMemoryMB = 2048;
                      flake = {
                        autoEvalInputs = true;
                      };
                    };
                  };
                };
              };
            };
          };
        };

        treesitter = {
          enable = true;
          grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [ 
            c-sharp 
            fsharp
            nix
          ];
          moduleConfig = {
            highlight.enable = true;
            indent.enable = true;
            incremental_selection = {
              enable = true;
              keymaps = {
                init_selection = "<CR>";
                node_incremental = "<CR>";
                node_decremental = "<BS>";
                scope_incremental = "<TAB>";
              };
            };
          };
        };

        treesitter-textobjects = {
          enable = true;
          select = {
            enable = true;
            lookahead = true;
            keymaps = {
              "af" = "@function.outer";
              "if" = "@function.inner";
              "ac" = "@class.outer";
              "ic" = "@class.inner";
              "aa" = "@parameter.outer";
              "ia" = "@parameter.inner";
            };
          };
          move = {
            enable = true;
            setJumps = true;
            gotoNextStart = {
              "]m" = "@function.outer";
              "]]" = "@class.outer";
            };
            gotoNextEnd = {
              "]M" = "@function.outer";
              "][" = "@class.outer";
            };
            gotoPreviousStart = {
              "[m" = "@function.outer";
              "[[" = "@class.outer";
            };
            gotoPreviousEnd = {
              "[M" = "@function.outer";
              "[]" = "@class.outer";
            };
          };
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

        # Debugging support
        dap = {
          enable = true;
        };
        dap-ui = {
          enable = true;
        };

        # Notification system
        notify = {
          enable = true;
          settings = {
            timeout = 3000;
            max_width = 80;
            max_height = 20;
            stages = "fade";
            background_colour = "#000000";
          };
        };

        # Quality of life improvements
        nvim-autopairs = {
          enable = true;
          settings = {
            check_ts = true;  # Use treesitter for better pairing
          };
        };

        comment = {
          enable = true;
        };

        # Modern UI components
        noice = {
          enable = true;
          settings = {
            cmdline = {
              enabled = true;
              view = "cmdline_popup";  # classic | cmdline_popup | cmdline
              opts = {
                border = {
                  style = "rounded";
                };
              };
            };
            messages = {
              enabled = true;
              view = "notify";
              view_error = "notify";
              view_warn = "notify";
              view_history = "messages";
              view_search = "virtualtext";
            };
            popupmenu = {
              enabled = true;
              backend = "nui";  # nui | cmp
            };
            notify = {
              enabled = true;
              view = "notify";
            };
            lsp = {
              progress = {
                enabled = true;
                view = "mini";
              };
              hover = {
                enabled = true;
                view = "hover";
              };
              signature = {
                enabled = true;
                view = "hover";
              };
              message = {
                enabled = true;
                view = "notify";
              };
            };
          };
        };

        # Required by noice.nvim
        nui = {
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
        # UI/Messages keymaps
        {
          key = "<leader>un";
          action = ":NoiceDismiss<CR>";
          mode = "n";
          options.desc = "Dismiss all messages";
        }
        {
          key = "<leader>ul";
          action = ":Noice last<CR>";
          mode = "n";
          options.desc = "Show last message";
        }
        {
          key = "<leader>uh";
          action = ":Noice history<CR>";
          mode = "n";
          options.desc = "Show message history";
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