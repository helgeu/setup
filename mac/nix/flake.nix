# Multi-machine Nix configuration (macOS + WSL)
{
  description = "Nix setup for macOS and WSL machines";

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

    # WSL support
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # macOS Homebrew integration
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

    claude-code.url = "github:sadjow/claude-code-nix";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
    nixos-wsl,
    nix-homebrew,
    homebrew-core,
    homebrew-cask,
    nvf,
    ...
  }: let
    darwinSystem = "aarch64-darwin";
    linuxSystem = "x86_64-linux";
  in {
    # Work Mac: NO-GLV6Y9N492
    darwinConfigurations."NO-GLV6Y9N492" = nix-darwin.lib.darwinSystem {
      system = darwinSystem;
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
            claude-code = inputs.claude-code;
          };
          home-manager.users.helgereneurholm = {...}: {
            imports = [
              ./home-manager/NO-GLV6Y9N492.nix
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
      system = darwinSystem;
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
              ./home-manager/Helges-MacBook-Pro.nix
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

    # WSL: wsl-work
    nixosConfigurations."wsl-work" = nixpkgs.lib.nixosSystem {
      system = linuxSystem;
      modules = [
        nixos-wsl.nixosModules.default
        ./system/wsl-work.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.verbose = true;
          home-manager.backupFileExtension = "backup";
          home-manager.extraSpecialArgs = {
            claude-code = inputs.claude-code;
          };
          home-manager.users.nixos = {...}: {
            imports = [
              ./home-manager/wsl-work.nix
              nvf.homeManagerModules.default
            ];
          };
        }
      ];
    };
  };
}
