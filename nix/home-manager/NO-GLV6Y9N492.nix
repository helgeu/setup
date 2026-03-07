{ ... }: {
  imports = [
    ./shared.nix
    ./macos-shared.nix
    ./work-tools.nix
  ];

  home.username = "helgereneurholm";
  home.homeDirectory = "/Users/helgereneurholm";
  home.stateVersion = "25.11";

}
