{
  config,
  pkgs,
  lib,
  ...
}: let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;
in {
  programs = {
    vscode = {
      # Disable on Linux/WSL - use Windows VS Code with Remote-WSL extension
      enable = isDarwin;
      # WORKAROUND for home-manager bug #8793 / #7880
      # profiles.default.extensions doesn't work after commit b593765 (Feb 2026)
      # Using legacy extensions option instead.
      #
      # TO REVERT when bug is fixed:
      # 1. Change `extensions = [...]` back to `profiles.default.extensions = [...]`
      # 2. The warning about renamed option will disappear
      # Allow mutable extensions dir so VS Code can install fast-updating extensions
      # like GitHub Copilot directly from marketplace (nixpkgs versions lag behind)
      mutableExtensionsDir = true;
      profiles.default.userSettings = {
        "editor.fontFamily" = "'MesloLGM Nerd Font','MesloLGS Nerd Font','MesloLGL Nerd Font', Menlo, Monaco, 'Courier New', monospace";
        "terminal.integrated.fontFamily" = "MesloLGM Nerd Font";
        "editor.fontLigatures" = true;
        "update.mode" = "none";  # Nix manages VS Code updates
        "chat.agent.enabled" = true;
        "fsharp.editor.inlayHints.enabled" = "off";
        "chat.agent.maxRequests" = 250;
        "chat.tools.terminal.autoApprove" = {
          "/^dotnet test$/" = {
            "approve" = true;
            "matchCommandLine" = true;
          };
        };
        "/^dotnet build$/" = {
          "approve" = true;
          "matchCommandLine" = true;
        };
      } // lib.optionalAttrs isDarwin {
        "terminal.integrated.defaultProfile.osx" = "pwsh";
        "powershell.powerShellAdditionalExePaths" = {
          "Nix pwsh" = "/etc/profiles/per-user/${config.home.username}/bin/pwsh";
        };
      } // lib.optionalAttrs isLinux {
        "terminal.integrated.defaultProfile.linux" = "pwsh";
      };
      # Using legacy extensions (not profiles.default.extensions) due to bug #8793
      # NOTE: Cannot use `with pkgs.vscode-extensions` because 42crunch starts with
      # a number and Nix identifiers can't start with numbers. Keep `with pkgs`.
      extensions = with pkgs; [
        vscode-extensions."42crunch".vscode-openapi
        vscode-extensions.redhat.vscode-yaml           # Required by vscode-openapi
        vscode-extensions.ionide.ionide-fsharp
        vscode-extensions.hediet.vscode-drawio
        vscode-extensions.chrischinchilla.vscode-pandoc
        vscode-extensions.bierner.markdown-mermaid
        vscode-extensions.ms-dotnettools.csharp                 # Required by csdevkit
        vscode-extensions.ms-dotnettools.vscode-dotnet-runtime  # Required by csdevkit
        vscode-extensions.ms-dotnettools.csdevkit
        vscode-extensions.jnoortheen.nix-ide
        vscode-extensions.ms-vscode.powershell
        # NOTE: GitHub Copilot extensions NOT managed by Nix - install via VS Code marketplace
        # Reason: nixpkgs versions lag behind and cause version compatibility errors
      ];
    };
  };
}
