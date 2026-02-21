# Multi-machine macOS Nix configuration
{
  description = "macOS setup for work and home machines";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };

    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    nvf = {
      url = "github:notashelf/nvf/";
    };

    adoboards = {
      url = "github:Wotee/adoboards-tui";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    claude-code.url = "github:sadjow/claude-code-nix";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
    nix-homebrew,
    homebrew-core,
    homebrew-cask,
    nvf,
    adoboards,
    ...
  }: let
    system = "aarch64-darwin";
  in {
    # Work Mac: NO-GLV6Y9N492
    darwinConfigurations."NO-GLV6Y9N492" = nix-darwin.lib.darwinSystem {
      inherit system;
      modules = [
        ./system/NO-GLV6Y9N492.nix
        ./dock/NO-GLV6Y9N492.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.verbose = true;
          home-manager.backupFileExtension = "backup";
          home-manager.extraSpecialArgs = {
            inherit adoboards;
            claude-code = inputs.claude-code;
          };
          home-manager.users.helgereneurholm = {...}: {
            imports = [
              ./home/NO-GLV6Y9N492.nix
              nvf.homeManagerModules.default
            ];
          };
        }
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            user = "helgereneurholm";
          };
        }
      ];
    };

    # Home Mac: Helges-MacBook-Pro
    darwinConfigurations."Helges-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      inherit system;
      modules = [
        ./system/Helges-MacBook-Pro.nix
        ./dock/Helges-MacBook-Pro.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.verbose = true;
          home-manager.backupFileExtension = "backup";
          home-manager.extraSpecialArgs = {
            claude-code = inputs.claude-code;
          };
          home-manager.users.helgeu = {...}: {
            imports = [
              ./home/Helges-MacBook-Pro.nix
              nvf.homeManagerModules.default
            ];
          };
        }
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            user = "helgeu";
          };
        }
      ];
    };
  };
}
