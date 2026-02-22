{ ... }: let
  hmApps = "/Users/helgereneurholm/Applications/Home Manager Apps";
in {
  imports = [./shared.nix];

  system.defaults.dock = {
    # Apps in the Dock (left side)
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
  };
}
