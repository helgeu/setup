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
      # Nix manages extensions as individual symlinks in a writable directory.
      # mutableExtensionsDir=true is required because VS Code (and built-in
      # Copilot Chat) writes temp/session files to the extensions dir at runtime.
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
      # Extensions from VS Code marketplace via nix-vscode-extensions (updated daily)
      # .NET extensions use nixpkgs versions (marketplace builds fail due to platform patches)
      profiles.default.extensions = [
        # GitHub Copilot Chat is auto-installed by VS Code at runtime — do NOT add here
        # OpenAPI
        marketplace."42crunch".vscode-openapi
        marketplace.redhat.vscode-yaml           # Required by vscode-openapi
        # .NET (nixpkgs - marketplace versions fail to build)
        pkgs.vscode-extensions.ms-dotnettools.vscode-dotnet-runtime
        pkgs.vscode-extensions.ms-dotnettools.csharp
        pkgs.vscode-extensions.ms-dotnettools.csdevkit
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
