# Shared LSP server definitions for nvf and Claude Code
# Single source of truth - no duplication
{ pkgs }:
let
  # Define LSP servers with their packages and Claude Code config
  servers = {
    nix = {
      package = pkgs.nil;
      command = "nil";
      extensions = { ".nix" = "nix"; };
    };
    typescript = {
      package = pkgs.typescript-language-server;
      command = "typescript-language-server";
      args = [ "--stdio" ];
      extensions = { ".ts" = "typescript"; ".tsx" = "typescriptreact"; ".js" = "javascript"; ".jsx" = "javascriptreact"; };
    };
    python = {
      package = pkgs.basedpyright;
      command = "basedpyright-langserver";
      args = [ "--stdio" ];
      extensions = { ".py" = "python"; };
    };
    lua = {
      package = pkgs.lua-language-server;
      command = "lua-language-server";
      extensions = { ".lua" = "lua"; };
    };
    bash = {
      package = pkgs.bash-language-server;
      command = "bash-language-server";
      args = [ "start" ];
      extensions = { ".sh" = "shellscript"; ".bash" = "shellscript"; };
    };
    yaml = {
      package = pkgs.yaml-language-server;
      command = "yaml-language-server";
      args = [ "--stdio" ];
      extensions = { ".yaml" = "yaml"; ".yml" = "yaml"; };
    };
    markdown = {
      package = pkgs.marksman;
      command = "marksman";
      args = [ "server" ];
      extensions = { ".md" = "markdown"; };
    };
    fsharp = {
      package = pkgs.fsautocomplete;
      command = "fsautocomplete";
      extensions = { ".fs" = "fsharp"; ".fsx" = "fsharp"; ".fsi" = "fsharp"; };
    };
    csharp = {
      package = pkgs.omnisharp-roslyn;
      command = "OmniSharp";
      args = [ "--languageserver" ];
      extensions = { ".cs" = "csharp"; };
    };
  };

  # Extract just the packages for home.packages
  packages = builtins.map (s: s.package) (builtins.attrValues servers);

  # Generate Claude Code .lsp.json format
  claudeLspConfig = builtins.listToAttrs (builtins.map (name: {
    inherit name;
    value = {
      command = servers.${name}.command;
      extensionToLanguage = servers.${name}.extensions;
    } // (if servers.${name} ? args then { args = servers.${name}.args; } else {});
  }) (builtins.attrNames servers));

  # Write JSON file
  claudeLspJson = pkgs.writeText "lsp.json" (builtins.toJSON claudeLspConfig);

in {
  inherit packages claudeLspJson claudeLspConfig servers;
}
