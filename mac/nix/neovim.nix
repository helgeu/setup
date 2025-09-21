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
        (import ./neovim/plugins/ui { inherit pkgs; }).plugins //
        (import ./neovim/plugins/git { inherit pkgs; }).plugins //
        (import ./neovim/plugins/debug { inherit pkgs; }).plugins //
        (import ./neovim/plugins/editor { inherit pkgs; }).plugins //
        (import ./neovim/plugins/statusline { inherit pkgs; }).plugins;

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