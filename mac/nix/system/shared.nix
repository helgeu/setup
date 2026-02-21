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
      # Brave Browser settings and policies
      # Installed via Homebrew to preserve Apple code signature for iCloud Passwords
      "com.brave.Browser" = {
        # Disable Sparkle auto-updates (Homebrew manages updates)
        SUAutomaticallyUpdate = false;
        SUEnableAutomaticChecks = false;
        # Enterprise policies (Chromium-based)
        # Disable background mode (equivalent to --disable-background-networking)
        BackgroundModeEnabled = false;
        # Disable built-in password manager onboarding (using iCloud Passwords instead)
        PasswordManagerEnabled = false;
        # Disable payment autofill to cloud storage
        AutofillCreditCardEnabled = false;
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
