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
  
  avante-nvim = {
    package = import ./avante.nix {inherit pkgs;};
    setup = ''
      require('avante').setup({
        provider = 'copilot',
        auto_suggestions_provider = 'copilot',
        behaviour = {
          auto_suggestions = false,
          auto_set_highlight_group = true,
          auto_apply_diff_after_generation = false,
          support_paste_from_clipboard = true,
        },
      })
    '';
  };
}
