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
}
