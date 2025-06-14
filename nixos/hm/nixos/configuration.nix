# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:

{
  imports = [];

  wsl.enable = true;
  wsl.defaultUser = "nixos";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  # Enable Flakes
  nix.package = pkgs.nixVersions.stable;
  nix.extraOptions = '';
    experimental-features = nix-command flakes
    '';

  users.users.nixos = {
    isNormalUser = true;
    description = "nixos";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;
  nix.settings.download-buffer-size = 102410231022;
  services.tzupdate.enable = true;

  programs.nvf = {
      enable = true;
      settings = {
          vim.theme.enable=true;
          #vim.languages.nix.enable = true;
          #vim.languages.enableLSP = true;
          #vim.languages.enableTreeSitter = true;
          #nix.enable = true;
          #csharp.enable=true;
          #fsharp.enable=true;
        };
    };
}
