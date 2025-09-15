# ~/.config/nix/flake.nix

{
  description = "Initial MacOs setup";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
        url = "github:LnL7/nix-darwin";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager, ... }:
  let
    system = "aarch-darwin";
    username = "helgereneurholm";
    pkgs = import nixpkgs {inherit system; config.allowunfree = true; };

    homeconfig = {pkgs, ...}: {
        # this is internal compatibility configuration
        # for home-manager, dont change this!
        home.stateVersion = "25.05";
        # let home-manager install and manage itself.
        programs.home-manager.enable = true;
 
        home.packages = with pkgs; [];

        home.sessionVariables = {
	    EDITOR = "vim";
        };
	home.file.".vimrc".source = ./vim_configuration;
     };
  in
  {
    darwinConfigurations."X-GLV6Y9N492" = nix-darwin.lib.darwinSystem {
      modules = [
         ./configuration.nix
         home-manager.darwinModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.verbose = true;
            home-manager.users.helgereneurholm = import ./work.nix;
         }
      ];
    };
  };
}
