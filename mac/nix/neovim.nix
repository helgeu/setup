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
      keymaps = (import ./neovim/keymaps { inherit pkgs; }).keymaps;

      globals.mapleader = " ";
    };
  };
}