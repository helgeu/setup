# Main nixvim configuration entry point
{pkgs, ...}: {
  programs.nixvim = {
    # Configuration modules
    imports = [
      # Core configuration
      (import ./nixvim/options.nix { inherit pkgs; })
      (import ./nixvim/autocmds.nix { inherit pkgs; })
      (import ./nixvim/plugins/snacks.nix { inherit pkgs; })

      # UI and theme
      (import ./nixvim/catppuccin.nix { inherit pkgs; })

      # Code intelligence
      (import ./nixvim/lsp.nix { inherit pkgs; })
      (import ./nixvim/diagnostics.nix { inherit pkgs; })
      (import ./nixvim/completion.nix { inherit pkgs; })
      (import ./nixvim/treesitter.nix { inherit pkgs; })

      # Language-specific
      (import ./nixvim/languages/fsharp.nix { inherit pkgs; })
    ];
    
    config = {
      enable = true;
      viAlias = true;
      vimAlias = true;

      extraPackages = with pkgs; [
        # Python with updated pynvim
        (python3.withPackages (ps: with ps; [
          (pynvim.overridePythonAttrs (old: {
            version = "0.6.0";
          }))
        ]))
        # Node and tree-sitter CLI
        nodejs
        tree-sitter
      ];

      options.mapleader = " ";

      plugins = 
        # Import all plugin configurations and merge them
        (import ./nixvim/plugins/ui { inherit pkgs; }).plugins //
        (import ./nixvim/plugins/git { inherit pkgs; }).plugins //
        (import ./nixvim/plugins/debug { inherit pkgs; }).plugins //
        (import ./nixvim/plugins/editor { inherit pkgs; }).plugins //
        (import ./nixvim/plugins/statusline { inherit pkgs; }).plugins;

      globals.mapleader = " ";
    };
  };
}