{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./shared.nix
  ];

  # Work user
  users.users.helgereneurholm = {
    name = "helgereneurholm";
    home = "/Users/helgereneurholm";
  };

  system.primaryUser = "helgereneurholm";

  # Work-specific homebrew packages
  homebrew = {
    enable = true;
    onActivation.upgrade = true;
    onActivation.autoUpdate = true;

    taps = [];
    brews = [
      "bruno-cli"
      "mas"
    ];
    casks = [
      "rancher"
      "bruno"
    ];
    masApps = {
      Xcode = 497799835;
    };
  };
}
