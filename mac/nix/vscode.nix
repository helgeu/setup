{
  config,
  pkgs,
  ...
}: {
  programs = {
    vscode = {
      enable = true;
      profiles.default.userSettings = {
        "editor.fontFamily" = "'MesloLGM Nerd Font','MesloLGS Nerd Font','MesloLGL Nerd Font', Menlo, Monaco, 'Courier New', monospace";
        "terminal.integrated.fontFamily" = "MesloLGM Nerd Font";
        "editor.fontLigatures" = true;
        "chat.agent.enabled" = true;
        "fsharp.editor.inlayHints.enabled" = "off";
        "terminal.integrated.defaultProfile.osx" = "pwsh";
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
