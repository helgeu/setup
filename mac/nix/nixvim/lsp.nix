{ pkgs, ... }: {
  config = {
    plugins = {
      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true; # Nix
          fsautocomplete = {    # F#
            enable = true;
            extraOptions = {
              AutomaticWorkspaceInit = true;
            };
          };
          omnisharp = {        # C#
            enable = true;
            package = pkgs.omnisharp-roslyn;
            extraOptions = {
              enable_import_completion = true;
              enable_roslyn_analyzers = true;
              organize_imports_on_format = true;
              enable_ms_build_load_projects_on_demand = true;
              sdk_include_prereleases = true;
            };
          };
        };
      };

      cmp-nvim-lsp.enable = true;
    };
  };
}