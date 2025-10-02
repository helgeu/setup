{ pkgs, ... }: {
  config.autoCmd = [
    {
      event = "FileType";
      pattern = "nix";
      command = "setlocal tabstop=2 shiftwidth=2";  # Nix files typically use 2 spaces
    }
    {
      event = "BufWritePre";
      pattern = "*.nix";
      command = "lua vim.lsp.buf.format()";  # Format Nix files on save
    }
    {
      event = "FileType";
      pattern = [ "fsharp" "fs" "fsi" "fsx" ];
      command = "setlocal expandtab tabstop=4 shiftwidth=4";  # F# convention
    }
    {
      event = [ "BufNewFile" "BufRead" ];
      pattern = [ "*.fs" "*.fsx" "*.fsi" ];
      command = "setfiletype fsharp";  # Ensure proper filetype detection
    }
    {
      event = "BufWritePre";
      pattern = [ "*.fs" "*.fsx" "*.fsi" ];
      command = "lua vim.lsp.buf.format()";  # Format F# files on save
    }
  ];
}