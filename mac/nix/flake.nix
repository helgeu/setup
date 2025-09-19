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
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    # Optional: Declarative tap management
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    
    # Nixvim configuration
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      nix-homebrew,
      homebrew-core,
      homebrew-cask,
      nixvim,
      ...
    }:
    let
      system = "aarch64-darwin";
      username = "helgereneurholm";
      pkgs = import nixpkgs {
        inherit system;
        config.allowunfree = true;
        overlays = [ nixvim.overlays.default ];
      };

    in
    {
      darwinConfigurations."X-GLV6Y9N492" = nix-darwin.lib.darwinSystem {
        modules = [
          ./configuration.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.verbose = true;
            home-manager.users.helgereneurholm = { ... }: {
              imports = [ 
                nixvim.homeModules.nixvim
                ./work.nix
              ];
            };
          }
        ];
      };
    };
}
