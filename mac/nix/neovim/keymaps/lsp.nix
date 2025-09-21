# LSP-related keymaps
{ pkgs, ... }: {
  keymaps = [
    {
      key = "<leader>fs";
      action = ":lua vim.lsp.buf.signature_help()<CR>";
      mode = "n";
      options.desc = "Signature help";
    }
    {
      key = "<leader>fr";
      action = ":lua vim.lsp.buf.rename()<CR>";
      mode = "n";
      options.desc = "Rename symbol";
    }
    {
      key = "<leader>fa";
      action = ":lua vim.lsp.buf.code_action()<CR>";
      mode = "n";
      options.desc = "Code actions";
    }
    {
      key = "<leader>fd";
      action = ":lua vim.lsp.buf.definition()<CR>";
      mode = "n";
      options.desc = "Go to definition";
    }
    {
      key = "<leader>fi";
      action = ":lua vim.lsp.buf.implementation()<CR>";
      mode = "n";
      options.desc = "Go to implementation";
    }
    {
      key = "<leader>ft";
      action = ":lua vim.lsp.buf.type_definition()<CR>";
      mode = "n";
      options.desc = "Type definition";
    }
    {
      key = "<leader>fh";
      action = ":lua vim.lsp.buf.hover()<CR>";
      mode = "n";
      options.desc = "Hover information";
    }
    {
      key = "<leader>fu";
      action = ":lua vim.lsp.buf.references()<CR>";
      mode = "n";
      options.desc = "Find references";
    }
    {
      key = "<leader>ff";
      action = ":lua vim.lsp.buf.format()<CR>";
      mode = "n";
      options.desc = "Format code";
    }
  ];
}