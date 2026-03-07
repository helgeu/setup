{ ... }: {
  imports = [
    ./shared.nix
  ];

  # Home user
  users.users.helgeu = {
    name = "helgeu";
    home = "/Users/helgeu";
  };

  system.primaryUser = "helgeu";

  # Home-specific homebrew packages (base config in shared.nix)
  homebrew = {
    masApps = {
      Slack = 803453959;
      Telegram = 747648890;
    };
  };
}
