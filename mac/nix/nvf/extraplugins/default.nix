# Aggregates all extra plugins for NVF
# extraPlugins expects an attrset where each attribute is a submodule with 'package' and optional setup
{
  pkgs,
  ...
}: {
  adoboards-nvim = {
    package = import ./adoboards.nix {inherit pkgs;};
    setup = ''
      require('adoboards').setup({
        -- Configuration will be loaded from ~/Library/Application Support/adoboards/default-config.toml
      })
    '';
  };
}
