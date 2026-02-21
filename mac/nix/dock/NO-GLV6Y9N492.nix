{
  config,
  pkgs,
  lib,
  ...
}: let
  # Helper: Home Manager apps are installed here
  hmApps = "/Users/helgereneurholm/Applications/Home Manager Apps";
in {
  system.defaults.dock = {
    # Appearance
    autohide = true;
    autohide-delay = 0.0; # No delay before hiding
    autohide-time-modifier = 0.4; # Faster hide/show animation
    tilesize = 48;
    magnification = false;
    orientation = "bottom";
    show-recents = true; # Show recent apps
    showhidden = true; # Translucent icons for hidden apps

    # Animation
    launchanim = true;
    mineffect = "scale"; # Scale is faster than genie
    minimize-to-application = true;

    # Behavior
    mru-spaces = false; # Don't rearrange Spaces automatically
    show-process-indicators = true;

    # Apps in the Dock (left side)
    # Order matters - this is the order they appear
    persistent-apps = [
      # Browsers (Brave via Homebrew for iCloud Passwords compatibility)
      "/Applications/Safari.app"
      "/Applications/Brave Browser.app"
      "/Applications/Microsoft Edge.app"

      # Communication
      "/Applications/Microsoft Outlook.app"
      "/Applications/Microsoft Teams.app"
      "/Applications/Slack.app"

      # Development
      "${hmApps}/Visual Studio Code.app"
      "${hmApps}/Rider.app"
      "${hmApps}/iTerm2.app"
      "/Applications/Xcode.app"

      # Utilities
      "/Applications/Rancher Desktop.app"
      "/Applications/keymapp.app"

      # System
      "/System/Applications/App Store.app"
      "/System/Applications/System Settings.app"
    ];

    # Folders/files (right side of Dock, after the separator)
    persistent-others = [
      "/Users/helgereneurholm/Downloads"
      "/Users/helgereneurholm/Documents"
      "/Users/helgereneurholm/ado"
      "/Users/helgereneurholm/git"
      "/Users/helgereneurholm/urholmvs"
    ];

    # Hot corners (optional - uncomment if desired)
    # Values: 1=Disabled, 2=Mission Control, 3=App Windows, 4=Desktop,
    #         5=Screen Saver, 10=Sleep Display, 11=Launchpad,
    #         12=Notification Center, 13=Lock Screen, 14=Quick Note
    # wvous-tl-corner = 2;  # Top-left: Mission Control
    # wvous-tr-corner = 12; # Top-right: Notification Center
    # wvous-bl-corner = 1;  # Bottom-left: Disabled
    # wvous-br-corner = 4;  # Bottom-right: Desktop
  };
}
