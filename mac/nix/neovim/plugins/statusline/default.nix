# Status line plugin configuration
{ pkgs, ... }: {
  plugins = {
    # Status line with code context
    lualine = {
      enable = true;
      settings.sections = {
        lualine_c = [
          "filename"
          "require('nvim-navic').get_location()"
        ];
      };
    };

    # Code context in statusline
    navic = {
      enable = true;
      settings = {
        lsp.auto_attach = true;     # Automatically attach to LSP
        highlight = true;          # Highlight the context path
      };
    };
  };
}