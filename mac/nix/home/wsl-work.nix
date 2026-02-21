{
  config,
  pkgs,
  lib,
  adoboards,
  ...
}: {
  imports = [
    ./shared.nix
    ../adoboards-config.nix
  ];

  home.username = "helge";
  home.homeDirectory = "/home/helge";
  home.stateVersion = "24.05";

  # Work-specific packages (Linux versions)
  home.packages = with pkgs; [
    # Azure / Cloud
    (azure-cli.withExtensions [
      azure-cli-extensions.azure-devops
      azure-cli-extensions.resource-graph
      azure-cli-extensions.application-insights
    ])
    azure-functions-core-tools
    bicep

    # .NET development
    omnisharp-roslyn
    fsautocomplete

    # JetBrains
    jetbrains.rider

    # JS/Node
    pnpm

    # Database
    sqlcmd

    # Utilities
    tmuxinator
    zip
    nil

    # Azure DevOps TUI
    adoboards.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
