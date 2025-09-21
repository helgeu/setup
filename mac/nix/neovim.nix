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

      plugins = 
        # Import all plugin configurations and merge them
        (import ./neovim/plugins/ui/telescope.nix { inherit pkgs; }).plugins //
        (import ./neovim/plugins/ui/neotree.nix { inherit pkgs; }).plugins //
        (import ./neovim/plugins/git { inherit pkgs; }).plugins //
        (import ./neovim/plugins/debug { inherit pkgs; }).plugins //
        (import ./neovim/plugins/editor { inherit pkgs; }).plugins //
        (import ./neovim/plugins/statusline { inherit pkgs; }).plugins // {
        # Key binding menu
        which-key = {
          enable = true;
          settings.plugins.presets = {
            operators = true;
            motions = true;
            text_objects = true;
            windows = true;
            nav = true;
            z = true;
            g = true;
          };
          settings.icons = {
            breadcrumb = "»";
            separator = "➜";
            group = "+";
          };
          settings.window = {
            border = "single";
            position = "bottom";
            margin = { top = 1; right = 0; bottom = 1; left = 0; };
            padding = { top = 1; right = 2; bottom = 1; left = 2; };
          };
          settings.layout = {
            height = { min = 4; max = 25; };
            width = { min = 20; max = 50; };
            spacing = 3;
            align = "left";
          };
          settings.spec = [
            {
              mode = "n";
              prefix = "<leader>n";
              name = "+nix";
            }
            {
              mode = "n";
              prefix = "<leader>g";
              name = "+git";
            }
            {
              mode = "n";
              prefix = "<leader>u";
              name = "+ui";
            }
            {
              mode = "n";
              prefix = "<leader>d";
              name = "+debug";
            }
          ];
        };
        web-devicons.enable = true;










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


      ];

      globals.mapleader = " ";
    };
  };
}