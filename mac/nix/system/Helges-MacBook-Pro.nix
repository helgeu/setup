{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./shared.nix
  ];

  # Home user
  users.users.helgeu = {
    name = "helgeu";
    home = "/Users/helgeu";
  };

  system.primaryUser = "helgeu";

  # Home-specific homebrew packages
  homebrew = {
    enable = true;
    onActivation.upgrade = true;
    onActivation.autoUpdate = true;

    taps = [];
    brews = [
      "mas"
    ];
    casks = [
      "brave-browser"
    ];
    masApps = {
      Xcode = 497799835;
      Slack = 803453959;
      Telegram = 747648890;
    };
  };
}
