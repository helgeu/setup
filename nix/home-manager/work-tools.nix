# Shared work development tools (macOS work machine + WSL)
{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # Azure / Cloud
    azure-functions-core-tools
    bicep

    # JS/Node
    pnpm

    # Database
    sqlcmd

    # Utilities
    tmuxinator
  ];
}
