{ pkgs, ... }: {
  imports = [
    ./shared.nix
    ./macos-shared.nix
  ];

  home.username = "helgeu";
  home.homeDirectory = "/Users/helgeu";
  home.stateVersion = "25.11";

  # Home Mac-specific packages
  home.packages = with pkgs; [
    firefox
  ];
}
