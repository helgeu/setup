{ pkgs, ... }:
{
  plugins.snacks = {
    enable = true;
    autoLoad = true;
    settings = {
      # Global options
      keymap_opts = {
        silent = true;
        noremap = true;
      };

      # Picker configuration
      picker = {
        keymaps = {
          # File operations
          find_files = "<leader>ff";
          live_grep = "<leader>fg";
          buffers = "<leader>fb";
          help_tags = "<leader>fh";
          oldfiles = "<leader>fr";

          # Git operations
          git_files = "<leader>gf";
          git_status = "<leader>gs";
          git_commits = "<leader>gc";
          git_log = "<leader>gl";

          # LSP operations
          lsp_references = "gr";
          lsp_definitions = "gd";
          lsp_implementations = "gi";
          lsp_type_definitions = "gy";
          diagnostics = "<leader>fd";

          # Miscellaneous
          commands = "<leader>fc";
          command_history = "<leader>:";
          colorschemes = "<leader>uC";
        };
        options = {
          theme = "ivy";
          layout_config = {
            height = 0.6;
            width = 0.8;
          };
          previewer = true;
          hidden = true;
          no_ignore = false;
          follow = true;
          git_status = {
            show_untracked = true;
          };
        };
      };

      # Explorer configuration
      explorer = {
        enable = true;
        keymaps = {
          # Core operations
          toggle = "<leader>e";
          focus = "<leader>o";
          refresh = "R";
          close = "q";

          # Navigation
          expand = "<space>";
          open = "o";
          parent_dir = "h";
          child_dir = "l";

          # File operations
          create = "a";
          delete = "d";
          rename = "r";
          cut = "x";
          copy = "c";
          paste = "p";
          
          # Extra operations
          toggle_hidden = ".";
          toggle_gitignore = "gi";
          system_open = "s";
        };
        options = {
          # Display options
          width = 30;
          group_empty_dirs = true;
          hijack_netrw = true;
          respect_gitignore = true;
          show_hidden = false;
          sort_case_insensitive = true;
          
          # Git integration
          git = {
            enable = true;
            show_ignored = false;
            timeout = 400;
          };

          # Icons and UI
          icons = {
            show = true;
            default = "📄";
            directory = "📁";
            git = {
              unstaged = "✗";
              staged = "✓";
              unmerged = "⌥";
              renamed = "➜";
              untracked = "★";
              deleted = "⊖";
              ignored = "◌";
            };
          };
        };
      };
    };
  };
}