{ ... }: {
  imports = [
    ./shared.nix
    ./work-tools.nix
  ];

  home.username = "nixos";
  home.homeDirectory = "/home/nixos";
  home.stateVersion = "24.05";
}
