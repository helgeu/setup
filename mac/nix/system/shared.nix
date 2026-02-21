{
  config,
  pkgs,
  ...
}: {
  # Nix settings
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # Used for backwards compatibility
  system.stateVersion = 5;

  # Platform (both Macs are Apple Silicon)
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  # Shared system packages
  environment.systemPackages = with pkgs; [
  ];

  # Shared system defaults
  system.defaults = {
    finder.AppleShowAllFiles = true;
    CustomUserPreferences = {
      NSGlobalDomain = {
        WebKitDeveloperExtras = true;
      };
      "com.apple.finder" = {
        ShowExternalHardDrivesOnDesktop = true;
        ShowHardDrivesOnDesktop = true;
        ShowMountedServersOnDesktop = true;
        ShowRemovableMediaOnDesktop = true;
        _FXSortFoldersFirst = true;
        FXDefaultSearchScope = "SCcf";
      };
      "com.apple.desktopservices" = {
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };
      "com.apple.screencapture" = {
        location = "~/Documents/Screenshots";
        type = "png";
      };
    };
    NSGlobalDomain = {
      AppleShowScrollBars = "Always";
      "com.apple.keyboard.fnState" = true;
    };
    controlcenter.Bluetooth = true;
    controlcenter.Sound = true;
  };

  # Shared fonts
  fonts.packages = with pkgs; [
    nerd-fonts.meslo-lg
    nerd-fonts.fira-code
  ];
}
