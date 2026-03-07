{ ... }: {
  imports = [
    ./shared.nix
  ];

  # Work user
  users.users.helgereneurholm = {
    name = "helgereneurholm";
    home = "/Users/helgereneurholm";
  };

  system.primaryUser = "helgereneurholm";

  # Work-specific homebrew packages (base config in shared.nix)
  homebrew = {
    brews = [
      "bruno-cli"
    ];
    casks = [
      "rancher"
      "bruno"
    ];
  };
}
