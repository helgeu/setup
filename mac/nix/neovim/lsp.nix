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
        };
      };

      cmp-nvim-lsp.enable = true;
      
      which-key.settings.spec = [
        {
          mode = "n";
          prefix = "<leader>f";
          name = "+lsp";
          s = { command = "lua vim.lsp.buf.signature_help()"; desc = "Signature Help"; };
          r = { command = "lua vim.lsp.buf.rename()"; desc = "Rename"; };
          a = { command = "lua vim.lsp.buf.code_action()"; desc = "Code Action"; };
          d = { command = "lua vim.lsp.buf.definition()"; desc = "Go to Definition"; };
          i = { command = "lua vim.lsp.buf.implementation()"; desc = "Go to Implementation"; };
          t = { command = "lua vim.lsp.buf.type_definition()"; desc = "Type Definition"; };
          h = { command = "lua vim.lsp.buf.hover()"; desc = "Hover"; };
          u = { command = "lua vim.lsp.buf.references()"; desc = "References"; };
          f = { command = "lua vim.lsp.buf.format()"; desc = "Format"; };
        }
      ];
    };
  };
}