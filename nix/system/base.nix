{ pkgs, lib, ... }: {
  # Cross-platform Nix settings
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # Automatic garbage collection (keep last 30 days)
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 30d";
  } // lib.optionalAttrs pkgs.stdenv.isDarwin {
    # nix-darwin: launchd interval (Sunday 3am)
    interval = { Weekday = 7; Hour = 3; Minute = 0; };
  } // lib.optionalAttrs pkgs.stdenv.isLinux {
    # NixOS: systemd calendar format
    dates = "weekly";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Shared fonts
  fonts.packages = with pkgs; [
    nerd-fonts.meslo-lg
    nerd-fonts.fira-code
  ];
}
