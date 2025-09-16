{
  config,
  pkgs,
  lib,
  ...
}: let
  combinedDotnet = with pkgs.dotnetCorePackages;
    combinePackages [
      sdk_8_0
      sdk_9_0
      runtime_8_0	
    ];
in {
  home.username = "helgereneurholm";
  home.homeDirectory = "/Users/helgereneurholm";

  home.stateVersion = "25.05";

  home.packages = [
    pkgs.git
    pkgs.neovim
    pkgs.zsh
    pkgs.unzip # Unzip for Mason LSPs and stuff
    pkgs.tmux
    pkgs.tmuxinator
  #  pkgs.azure-cli
    pkgs.fzf
    pkgs.lazygit
    combinedDotnet
    pkgs.azure-functions-core-tools
    pkgs.bicep
    pkgs.oh-my-posh
    pkgs.zip
    pkgs.bruno
    pkgs.git-credential-manager
    pkgs.powershell
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    DOTNET_ROOT = "${combinedDotnet}/share/dotnet";
    MANPAGER = "nvim +Man!";
  };

  programs.home-manager.enable = true;
}
