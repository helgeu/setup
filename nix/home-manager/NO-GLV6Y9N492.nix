{ pkgs, ... }: {
  imports = [
    ./shared.nix
    ./macos-shared.nix
    ./work-tools.nix
  ];

  home.username = "helgereneurholm";
  home.homeDirectory = "/Users/helgereneurholm";
  home.stateVersion = "25.11";

  # JetBrains Rider (macOS GUI IDE; not replicated to WSL machines)
  home.packages = [ pkgs.jetbrains.rider ];

  # Work-mac-only: authenticate VS Code against GitHub Enterprise (GHE.com),
  # not github.com. Merges into the shared userSettings from ../vscode.nix.
  # Both settings are required per GitHub docs for Copilot on GHE.com:
  #   1. github-enterprise.uri  -> the GHE.com tenant URL
  #   2. github.copilot.advanced.authProvider = "github-enterprise"
  #      -> tells Copilot to auth against the enterprise provider, not github.com
  programs.vscode.profiles.default.userSettings = {
    "github-enterprise.uri" = "https://itera.ghe.com";
    "github.copilot.advanced".authProvider = "github-enterprise";
  };
}
