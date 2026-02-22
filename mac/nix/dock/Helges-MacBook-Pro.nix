{ ... }: let
  hmApps = "/Users/helgeu/Applications/Home Manager Apps";
in {
  imports = [./shared.nix];

  system.defaults.dock = {
    # Apps in the Dock
    persistent-apps = [
      # Browsers (Brave via Homebrew for iCloud Passwords compatibility)
      "/System/Cryptexes/App/System/Applications/Safari.app"
      "/Applications/Brave Browser.app"
      "${hmApps}/Firefox.app"
      "/Applications/Tor Browser.app"

      # Communication
      "/Applications/Slack.app"
      "/Applications/Telegram.app"
      "/Applications/Signal.app"

      # Development
      "${hmApps}/Visual Studio Code.app"
      "${hmApps}/iTerm2.app"
      "/Applications/Xcode.app"

      # iWork
      "/Applications/Pages.app"
      "/Applications/Numbers.app"
      "/Applications/Keynote.app"

      # System
      "/System/Applications/App Store.app"
      "/System/Applications/System Settings.app"
    ];

    # Folders (right side of Dock)
    persistent-others = [
      "/Users/helgeu/Downloads"
      "/Users/helgeu/Documents"
    ];
  };
}
