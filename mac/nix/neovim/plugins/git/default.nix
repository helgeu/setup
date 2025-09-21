{pkgs, ...}: {
  plugins = {
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
          current_line_blame = true;
          current_line_blame_opts = {
            delay = 300;
          };
        };
      };

      # Classic git commands in vim
      fugitive.enable = true;

      # Lazygit integration
      lazygit.enable = true;
    };

    # Git-related keymaps
    keymaps = [
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
}