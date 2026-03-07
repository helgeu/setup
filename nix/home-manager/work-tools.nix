# Shared work development tools (macOS work machine + WSL)
{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # Azure / Cloud
    (azure-cli.withExtensions [
      azure-cli-extensions.azure-devops
      azure-cli-extensions.resource-graph
      azure-cli-extensions.application-insights
    ])
    azure-functions-core-tools
    bicep

    # JetBrains
    jetbrains.rider

    # JS/Node
    pnpm

    # Database
    sqlcmd

    # Utilities
    tmuxinator
  ];
}
