{
  config,
  pkgs,
  lib,
  ...
}: let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;
  marketplace = pkgs.vscode-marketplace;
in {
  programs = {
    vscode = {
      # Disable on Linux/WSL - use Windows VS Code with Remote-WSL extension
      enable = isDarwin;
      # Fully declarative - all extensions managed by nix-vscode-extensions
      mutableExtensionsDir = false;
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
      # Extensions from VS Code marketplace via nix-vscode-extensions (updated daily)
      profiles.default.extensions = [
        # GitHub Copilot
        marketplace.github.copilot
        marketplace.github.copilot-chat
        # OpenAPI
        marketplace."42crunch".vscode-openapi
        marketplace.redhat.vscode-yaml           # Required by vscode-openapi
        # .NET
        marketplace.ms-dotnettools.vscode-dotnet-runtime  # Required by csdevkit
        marketplace.ms-dotnettools.csharp                 # Required by csdevkit
        marketplace.ms-dotnettools.csdevkit
        # Languages
        marketplace.ionide.ionide-fsharp
        marketplace.jnoortheen.nix-ide
        marketplace.ms-vscode.powershell
        # Tools
        marketplace.hediet.vscode-drawio
        marketplace.chrischinchilla.vscode-pandoc
        marketplace.bierner.markdown-mermaid
      ];
    };
  };
}
