{ config, pkgs, inputs, lib, ... }:
let
  combinedDotnet = with pkgs.dotnetCorePackages; combinePackages [
    # Still needed in NCP unfortunately
    sdk_6_0
    sdk_8_0
    sdk_9_0
	runtime_8_0
  ];
in
{
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";
  home.stateVersion = "24.11";
  nixpkgs = {
		config = {
			allowUnfree = true;
			allowUnfreePredicate = (_: true);
		};
	};

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
	zsh
    unzip
    zip
    gccgo
    fnm
    jq
    stow
    azure-cli
    eza
    fzf
    lazygit
    combinedDotnet
    azure-functions-core-tools
    bicep
    oh-my-posh
    direnv
    bruno
	git
	git-credential-manager
  ];

  # Still needed in NCP unfortunately
  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-sdk-6.0.428"
  ];
  
  programs.neovim = {
  	enable = true;
  	viAlias = true;
	vimAlias = true;
  	};

	home.sessionVariables = {
		EDITOR="nvim";
		DOTNET_ROOT = "${combinedDotnet}/share/dotnet";
	};
	
	programs.zsh = {
		enable = true;
	};
}
