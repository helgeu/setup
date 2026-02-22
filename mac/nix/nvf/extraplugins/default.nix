# Aggregates all extra plugins for NVF
# extraPlugins expects an attrset where each attribute is a submodule with 'package' and optional setup
{
  pkgs,
  ...
}: {
  edgy-nvim = {
    package = pkgs.vimPlugins.edgy-nvim;
    setup = ''
      require('edgy').setup({
        -- LazyVim-style sidebar configuration
        left = {
          {
            title = "Explorer",
            ft = "snacks_explorer",
            pinned = true,
            open = function() Snacks.explorer.open() end,
          },
          { title = "Outline", ft = "Outline" },
        },
        bottom = {
          { title = "Trouble", ft = "trouble" },
          { title = "QuickFix", ft = "qf" },
          { title = "Terminal", ft = "terminal" },
        },
        right = {
          { title = "Help", ft = "help" },
        },
        options = {
          left = { size = 30 },
          bottom = { size = 10 },
          right = { size = 40 },
        },
      })
    '';
  };
}
