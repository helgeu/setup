{ ... }: {
  imports = [
    ./base.nix
  ];

  # Used for backwards compatibility
  system.stateVersion = 5;

  # Platform (both Macs are Apple Silicon)
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Shared system packages
  environment.systemPackages = [];

  # Shared macOS defaults
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
        # Note: ExtensionSettings doesn't work here - Brave reads enterprise policies
        # from /Library/Managed Preferences/, not user defaults. Extensions are managed
        # via External Extensions JSON files in home-manager/macos-shared.nix instead.
      };
    };
    NSGlobalDomain = {
      AppleShowScrollBars = "Always";
      "com.apple.keyboard.fnState" = true;
    };
    controlcenter.Bluetooth = true;
    controlcenter.Sound = true;
  };

  # Shared homebrew config
  homebrew = {
    enable = true;
    # Upgrades are applied at switch (activation), not at update time.
    # scripts/update.sh runs `brew update` to fetch new versions (the "find
    # upgrades" step); `darwin-rebuild switch` then upgrades formulae, casks,
    # and Mac App Store apps.
    onActivation.upgrade = true;
    onActivation.autoUpdate = false; # switch never runs `brew update`; update.sh does that
    global.autoUpdate = false; # no implicit 5-min brew auto-update on manual commands

    brews = [
      "mas"
    ];
    casks = [
      "alt-tab"  # Official Developer-ID build; nixpkgs build is ad-hoc signed and loops TCC Screen Recording prompts
      # Sparkle self-updater is disabled (see CustomUserPreferences above), so
      # greedy is required for the switch to upgrade it.
      { name = "brave-browser"; greedy = true; }
      "ghostty"
    ];
    masApps = {
      "Amazon Kindle" = 302584613;
      Xcode = 497799835;
    };
  };
}
