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
      # Microsoft's Roslyn LS - same backend as VS Code's C# Dev Kit.
      # Neovim uses it via the roslyn.nvim plugin (auto-discovers this binary on PATH).
      package = pkgs.roslyn-ls;
      command = "Microsoft.CodeAnalysis.LanguageServer";
      args = [
        "--stdio"
        "--logLevel=Information"
        "--extensionLogDirectory=/tmp/roslyn-ls-claude"
      ];
      extensions = { ".cs" = "csharp"; ".csx" = "csharp"; };
    };
    powershell = {
      # Wrapper script at ${pkgs.powershell-editor-services}/bin/powershell-editor-services
      # runs pwsh with Start-EditorServices.ps1, forwarding these args.
      package = pkgs.powershell-editor-services;
      command = "powershell-editor-services";
      args = [
        "-BundledModulesPath" "${pkgs.powershell-editor-services}/lib/powershell-editor-services"
        "-LogPath" "/tmp/pses-claude.log"
        "-SessionDetailsPath" "/tmp/pses-claude-session.json"
        "-FeatureFlags" "@()"
        "-HostName" "Claude"
        "-HostProfileId" "claude"
        "-HostVersion" "1.0.0"
        "-Stdio"
      ];
      extensions = { ".ps1" = "powershell"; ".psm1" = "powershell"; ".psd1" = "powershell"; };
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
