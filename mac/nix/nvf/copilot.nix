{
  pkgs,
  ...
}: {
  enable = true;
  
  setupOpts = {
    panel = {
      enabled = true;
      auto_refresh = false;
      keymap = {
        jump_prev = "[[";
        jump_next = "]]";
        accept = "<CR>";
        refresh = "gr";
        open = "<M-CR>";
      };
      layout = {
        position = "bottom";
        ratio = 0.4;
      };
    };
    
    suggestion = {
      enabled = true;
      auto_trigger = true;
      hide_during_completion = true;
      debounce = 75;
      keymap = {
        accept = "<M-l>";
        accept_word = false;
        accept_line = false;
        next = "<M-]>";
        prev = "<M-[>";
        dismiss = "<C-]>";
      };
    };
    
    filetypes = {
      yaml = false;
      markdown = false;
      help = false;
      gitcommit = false;
      gitrebase = false;
      hgcommit = false;
      svn = false;
      cvs = false;
      "." = false;
    };
    
    copilot_node_command = "${pkgs.nodejs}/bin/node";
    # Use GitHub CLI for authentication (integrates with git credential manager)
    server_opts_overrides = {
      settings = {
        advanced = {
          authProvider = "github-cli";
        };
      };
    };
  };
}
