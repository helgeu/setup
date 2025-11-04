{
  config,
  pkgs,
  ...
}: {
  # Necessary for using flakes on this system.
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # Used for backwards compatibility. please read the changelog
  # before changing: `darwin-rebuild changelog`.
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  # If you're on an Intel system, replace with "x86_64-darwin"
  nixpkgs.hostPlatform = "aarch64-darwin";

  nixpkgs.config.allowUnfree = true;

  # Declare the user that will be running `nix-darwin`.
  users.users.helgereneurholm = {
    name = "helgereneurholm";
    home = "/Users/helgereneurholm";
  };

  environment.systemPackages = with pkgs; [
    iterm2
    alt-tab-macos
  ];

  homebrew = {
    enable = true;
    # onActivation.cleanup = "uninstall";
    onActivation.upgrade = true;

    taps = [];
    brews = [
      "bruno-cli"
    ];
    casks = [
      "rancher"
      "bruno"
    ];
  };

  system.primaryUser = "helgereneurholm";
  #TODO: Move to script/alias switch?
  # system.activationScripts.postUserActivation.text = ''
  #   # Following line should allow us to avoid a logout/login cycle
  #   /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  # '';
  system.defaults = {
    finder.AppleShowAllFiles = true;
    CustomUserPreferences = {
      NSGlobalDomain = {
        # Add a context menu item for showing the Web Inspector in web views
        WebKitDeveloperExtras = true;
      };
      "com.apple.finder" = {
        ShowExternalHardDrivesOnDesktop = true;
        ShowHardDrivesOnDesktop = true;
        ShowMountedServersOnDesktop = true;
        ShowRemovableMediaOnDesktop = true;
        _FXSortFoldersFirst = true;
        # When performing a search, search the current folder by default
        FXDefaultSearchScope = "SCcf";
      };
      "com.apple.desktopservices" = {
        # Avoid creating .DS_Store files on network or USB volumes
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };
      # "com.apple.screensaver" = {
      #   # Require password immediately after sleep or screen saver begins
      #   askForPassword = 1;
      #   askForPasswordDelay = 0;
      # };
      "com.apple.screencapture" = {
        location = "~/Documents/Screenshots";
        type = "png";
      };
      # "com.apple.Safari" = {
      #   # Privacy: don’t send search queries to Apple
      #   UniversalSearchEnabled = false;
      #   SuppressSearchSuggestions = true;
      #   # Press Tab to highlight each item on a web page
      #   WebKitTabToLinksPreferenceKey = true;
      #   ShowFullURLInSmartSearchField = true;
      #   # Prevent Safari from opening ‘safe’ files automatically after downloading
      #   AutoOpenSafeDownloads = false;
      #   ShowFavoritesBar = false;
      #   IncludeInternalDebugMenu = true;
      #   IncludeDevelopMenu = true;
      #   WebKitDeveloperExtrasEnabledPreferenceKey = true;
      #   WebContinuousSpellCheckingEnabled = true;
      #   WebAutomaticSpellingCorrectionEnabled = false;
      #   AutoFillFromAddressBook = false;
      #   AutoFillCreditCardData = false;
      #   AutoFillMiscellaneousForms = false;
      #   WarnAboutFraudulentWebsites = true;
      #   WebKitJavaEnabled = false;
      #   WebKitJavaScriptCanOpenWindowsAutomatically = false;
      #   "com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks" = true;
      #   "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" = true;
      #   "com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled" = false;
      #   "com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled" = false;
      #   "com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabledForLocalFiles" = false;
      #   "com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically" = false;
      # };
      # "com.apple.mail" = {
      #   # Disable inline attachments (just show the icons)
      #   DisableInlineAttachmentViewing = true;
      # };
      # "com.apple.AdLib" = {
      #   allowApplePersonalizedAdvertising = false;
      # };
      # "com.apple.print.PrintingPrefs" = {
      #   # Automatically quit printer app once the print jobs complete
      #   "Quit When Finished" = true;
      # };
      # "com.apple.SoftwareUpdate" = {
      #   AutomaticCheckEnabled = true;
      #   # Check for software updates daily, not just once per week
      #   ScheduleFrequency = 1;
      #   # Download newly available updates in background
      #   AutomaticDownload = 1;
      #   # Install System data files & security updates
      #   CriticalUpdateInstall = 1;
      # };
      # "com.apple.TimeMachine".DoNotOfferNewDisksForBackup = true;
      # # Prevent Photos from opening automatically when devices are plugged in
      # "com.apple.ImageCapture".disableHotPlug = true;
      # # Turn on app auto-update
      # "com.apple.commerce".AutoUpdate = true;
    };
    NSGlobalDomain = {
      AppleShowScrollBars = "Always";
      "com.apple.keyboard.fnState" = true; # fn by default off
    };

    controlcenter.Bluetooth = true;
    controlcenter.Sound = true;
  };

  fonts.packages = with pkgs; [
    pkgs.nerd-fonts.meslo-lg
    pkgs.nerd-fonts.fira-code
  ];
}
