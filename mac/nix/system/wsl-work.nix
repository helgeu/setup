{
  config,
  pkgs,
  lib,
  ...
}: {
  # WSL-specific settings
  wsl = {
    enable = true;
    defaultUser = "nixos";
    startMenuLaunchers = true;

    # Windows interop
    interop = {
      includePath = true;
      register = true;
    };
  };

  # User configuration (nixos is the default WSL user)
  users.users.nixos = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    shell = pkgs.zsh;
  };

  # Enable zsh system-wide
  programs.zsh.enable = true;

  # Nix settings
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    trusted-users = ["root" "nixos"];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages
  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    vim
  ];

  # Fonts (same as macOS)
  fonts.packages = with pkgs; [
    nerd-fonts.meslo-lg
    nerd-fonts.fira-code
  ];

  # Timezone
  time.timeZone = "Europe/Oslo";

  # Networking
  networking.hostName = "wsl-work";

  # NixOS state version
  system.stateVersion = "24.05";
}
