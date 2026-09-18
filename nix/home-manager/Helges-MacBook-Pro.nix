{ ... }: {
  imports = [
    ./shared.nix
    ./macos-shared.nix
  ];

  home.username = "helgeu";
  home.homeDirectory = "/Users/helgeu";
  home.stateVersion = "25.11";

  # Firefox is installed via Homebrew cask (see system/Helges-MacBook-Pro.nix),
  # not Nix. The Nix build puts Firefox at a store path that changes on every
  # rebuild; Firefox keys its profile off the install path (installs.ini), so
  # each update looked like a "new install" and broke the default profile. The
  # cask installs to the stable /Applications/Firefox.app, keeping profiles put.
}
