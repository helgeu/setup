{
  config,
  pkgs,
  lib,
  ...
}: let
  hmApps = "/Users/helgeu/Applications/Home Manager Apps";
in {
  system.defaults.dock = {
    # Appearance
    autohide = true;
    autohide-delay = 0.0;
    autohide-time-modifier = 0.4;
    tilesize = 48;
    magnification = false;
    orientation = "bottom";
    show-recents = true;
    showhidden = true;

    # Animation
    launchanim = true;
    mineffect = "scale";
    minimize-to-application = true;

    # Behavior
    mru-spaces = false;
    show-process-indicators = true;

    # Apps in the Dock
    persistent-apps = [
      # Browsers
      "/Applications/Safari.app"
      "${hmApps}/Brave Browser.app"
      "${hmApps}/Firefox.app"
      "/Applications/Tor Browser.app"

      # Communication
      "/Applications/Slack.app"
      "/Applications/Telegram.app"
      "/Applications/Signal.app"

      # Development
      "${hmApps}/Visual Studio Code.app"
      "/Applications/Xcode.app"

      # iWork
      "/Applications/Pages.app"
      "/Applications/Numbers.app"
      "/Applications/Keynote.app"

      # System
      "/System/Applications/System Settings.app"
    ];

    # Folders (right side of Dock)
    persistent-others = [
      "/Users/helgeu/Downloads"
      "/Users/helgeu/Documents"
    ];
  };
}
