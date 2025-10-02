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
}