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

  # Work-mac-only: authenticate VS Code against GitHub Enterprise, not
  # github.com. Used by the built-in GitHub Authentication extension and
  # Copilot. Merges into the shared userSettings from ../vscode.nix.
  programs.vscode.profiles.default.userSettings."github-enterprise.uri" =
    "https://itera.ghe.com";
}
