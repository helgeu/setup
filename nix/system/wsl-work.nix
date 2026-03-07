{ pkgs, ... }: {
  imports = [
    ./base.nix
  ];

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

  # WSL-specific Nix settings
  nix.settings = {
    trusted-users = ["root" "nixos"];
  };

  # System packages
  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    vim
  ];

  # Timezone
  time.timeZone = "Europe/Oslo";

  # Networking
  networking.hostName = "wsl-work";

  # NixOS state version
  system.stateVersion = "24.05";
}
