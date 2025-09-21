{pkgs, ...}: {
  config = {
    plugins = {
      # Completion
      cmp = {
        enable = true;
        settings = {
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-n>" = "cmp.mapping.select_next_item()";
            "<C-p>" = "cmp.mapping.select_prev_item()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = "cmp.mapping.select_next_item()";
            "<S-Tab>" = "cmp.mapping.select_prev_item()";
          };
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "buffer"; }
            { name = "path"; }
          ];
          snippet.expand = "luasnip";
        };
      };

      # LSP completion source
      cmp-nvim-lsp.enable = true;
      
      # Buffer completion source
      cmp-buffer.enable = true;
      
      # Path completion source
      cmp-path.enable = true;

      # Snippet engine
      luasnip.enable = true;

      # Snippet completion source
      cmp_luasnip.enable = true;
    };
  };
}