{pkgs, ...}: {
  config = {
    plugins = {
      # Notification system for diagnostics
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

      # Modern UI components for diagnostics and messages
      noice = {
        enable = true;
        settings = {
          cmdline = {
            enabled = true;
            view = "cmdline_popup";
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
            backend = "nui";
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
      nui.enable = true;
    };

    # UI/Messages keymaps
    keymaps = [
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
    ];
  };
}