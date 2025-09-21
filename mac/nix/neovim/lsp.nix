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
      
      which-key.registrations = {
        "<leader>f" = {
          name = "+lsp";
          s = { action = ":lua vim.lsp.buf.signature_help()<CR>"; desc = "Signature Help"; };
          r = { action = ":lua vim.lsp.buf.rename()<CR>"; desc = "Rename"; };
          a = { action = ":lua vim.lsp.buf.code_action()<CR>"; desc = "Code Action"; };
          d = { action = ":lua vim.lsp.buf.definition()<CR>"; desc = "Go to Definition"; };
          i = { action = ":lua vim.lsp.buf.implementation()<CR>"; desc = "Go to Implementation"; };
          t = { action = ":lua vim.lsp.buf.type_definition()<CR>"; desc = "Type Definition"; };
          h = { action = ":lua vim.lsp.buf.hover()<CR>"; desc = "Hover"; };
          u = { action = ":lua vim.lsp.buf.references()<CR>"; desc = "References"; };
          f = { action = ":lua vim.lsp.buf.format()<CR>"; desc = "Format"; };
        };
      };
    };
  };
}