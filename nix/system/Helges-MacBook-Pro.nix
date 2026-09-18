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
    # Firefox via cask (stable /Applications path keeps profiles intact; the Nix
    # build's changing store path broke the profile on every rebuild).
    casks = [ "firefox" ];

    masApps = {
      Slack = 803453959;
      Telegram = 747648890;
    };
  };
}
