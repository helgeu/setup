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
      # programs.vscode.profiles.default.extensions
      profiles.default.extensions = with pkgs; [
        vscode-extensions."42crunch".vscode-openapi
        vscode-extensions.ionide.ionide-fsharp
        vscode-extensions.hediet.vscode-drawio
        vscode-extensions.chrischinchilla.vscode-pandoc
        vscode-extensions.bierner.markdown-mermaid
        vscode-extensions.ms-dotnettools.csdevkit
        vscode-extensions.jnoortheen.nix-ide

        vscode-extensions.ms-vscode.powershell
      ];
    };
  };
}
