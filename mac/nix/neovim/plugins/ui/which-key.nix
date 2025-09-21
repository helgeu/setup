# UI Enhancement plugins - Which-key menu and devicons
{ pkgs, ... }: {
  plugins = {
    # Icons for file types and folders
    web-devicons.enable = true;

    # Key binding menu and documentation
    which-key = {
      enable = true;
      settings = {
        plugins.presets = {
          operators = true;
          motions = true;
          text_objects = true;
          windows = true;
          nav = true;
          z = true;
          g = true;
        };
        icons = {
          breadcrumb = "»";
          separator = "➜";
          group = "+";
        };
        win = {
          border = "single";
          position = "bottom";
          margin = [ 1 0 1 0 ];  # top right bottom left
          padding = [ 1 2 ];  # [ vertical horizontal ]
        };
        layout = {
          height = { min = 4; max = 25; };
          width = { min = 20; max = 50; };
          spacing = 3;
          align = "left";
        };
        # Register common prefix groups
        groups = [
          { prefix = "<leader>n"; name = "+nix"; }
          { prefix = "<leader>g"; name = "+git"; }
          { prefix = "<leader>u"; name = "+ui"; }
          { prefix = "<leader>d"; name = "+debug"; }
          { prefix = "<leader>f"; name = "+lsp"; }
        ];
      };
    };
  };
  
  config = {
    keymaps = [
      # LSP Keymaps
      {
        key = "<leader>fs";
        action = ":lua vim.lsp.buf.signature_help()<CR>";
        mode = "n";
        options.desc = "Signature help";
      }
      {
        key = "<leader>fr";
        action = ":lua vim.lsp.buf.rename()<CR>";
        mode = "n";
        options.desc = "Rename symbol";
      }
      {
        key = "<leader>fa";
        action = ":lua vim.lsp.buf.code_action()<CR>";
        mode = "n";
        options.desc = "Code actions";
      }
      {
        key = "<leader>fd";
        action = ":lua vim.lsp.buf.definition()<CR>";
        mode = "n";
        options.desc = "Go to definition";
      }
      {
        key = "<leader>fi";
        action = ":lua vim.lsp.buf.implementation()<CR>";
        mode = "n";
        options.desc = "Go to implementation";
      }
      {
        key = "<leader>ft";
        action = ":lua vim.lsp.buf.type_definition()<CR>";
        mode = "n";
        options.desc = "Type definition";
      }
      {
        key = "<leader>fh";
        action = ":lua vim.lsp.buf.hover()<CR>";
        mode = "n";
        options.desc = "Hover information";
      }
      {
        key = "<leader>fu";
        action = ":lua vim.lsp.buf.references()<CR>";
        mode = "n";
        options.desc = "Find references";
      }
      {
        key = "<leader>ff";
        action = ":lua vim.lsp.buf.format()<CR>";
        mode = "n";
        options.desc = "Format code";
      }

      # Git Keymaps
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

      # Debug Keymaps
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

      # Nix Keymaps
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

      # UI Keymaps
      {
        key = "<C-n>";
        action = ":Neotree toggle<CR>";
        mode = "n";
        options.desc = "Toggle file explorer";
      }
      {
        key = "<leader>e";
        action = ":Neotree focus<CR>";
        mode = "n";
        options.desc = "Focus file explorer";
      }
      {
        key = "<leader>uf";
        action = ":Telescope find_files<CR>";
        mode = "n";
        options.desc = "Find files";
      }
      {
        key = "<leader>ug";
        action = ":Telescope live_grep<CR>";
        mode = "n";
        options.desc = "Live grep";
      }
      {
        key = "<leader>ub";
        action = ":Telescope buffers<CR>";
        mode = "n";
        options.desc = "Find buffers";
      }
      {
        key = "<leader>uh";
        action = ":Telescope help_tags<CR>";
        mode = "n";
        options.desc = "Find help";
      }

      # Diagnostic Keymaps
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
        key = "<leader>uo";
        action = ":Noice history<CR>";
        mode = "n";
        options.desc = "Show message history";
      }
    ];
  };
}