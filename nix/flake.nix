# Multi-machine Nix configuration (macOS + WSL)
{
  description = "Nix setup for macOS and WSL machines";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # TESTING: Using fork to test vscode fix (PR #8866)
    # Revert to: url = "github:nix-community/home-manager/master";
    home-manager = {
      url = "github:helgeu/home-manager/fix/vscode-extensions-json";
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
      inputs.nixpkgs.follows = "nixpkgs";
    };

    claude-code.url = "github:sadjow/claude-code-nix";

    rtk = {
      url = "github:helgeu/rtk/feat/nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # VS Code extensions from marketplace (updated daily)
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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

    overlays = [
      inputs.nix-vscode-extensions.overlays.default
      # TEMPORARY: Remove when https://github.com/NixOS/nixpkgs/pull/497478 is merged
      (import ./overlays/azure-cli-fix.nix)
    ];

    # Shared home-manager config for all platforms
    hmConfig = user: homeModule: {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.verbose = true;
      home-manager.backupFileExtension = "backup";
      home-manager.extraSpecialArgs = {
        claude-code = inputs.claude-code;
        rtk = inputs.rtk;
      };
      home-manager.users.${user} = {...}: {
        imports = [
          homeModule
          nvf.homeManagerModules.default
        ];
      };
    };

    # Helper to create a darwin configuration
    mkDarwin = {
      user,
      systemModule,
      dockModule,
      homeModule,
    }:
      nix-darwin.lib.darwinSystem {
        system = darwinSystem;
        modules = [
          {nixpkgs.overlays = overlays;}
          systemModule
          dockModule
          home-manager.darwinModules.home-manager
          (hmConfig user homeModule)
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              user = user;
            };
          }
        ];
      };
  in {
    # Work Mac: NO-GLV6Y9N492
    darwinConfigurations."NO-GLV6Y9N492" = mkDarwin {
      user = "helgereneurholm";
      systemModule = ./system/NO-GLV6Y9N492.nix;
      dockModule = ./dock/NO-GLV6Y9N492.nix;
      homeModule = ./home-manager/NO-GLV6Y9N492.nix;
    };

    # Home Mac: Helges-MacBook-Pro
    darwinConfigurations."Helges-MacBook-Pro" = mkDarwin {
      user = "helgeu";
      systemModule = ./system/Helges-MacBook-Pro.nix;
      dockModule = ./dock/Helges-MacBook-Pro.nix;
      homeModule = ./home-manager/Helges-MacBook-Pro.nix;
    };

    # WSL: wsl-work
    nixosConfigurations."wsl-work" = nixpkgs.lib.nixosSystem {
      system = linuxSystem;
      modules = [
        {nixpkgs.overlays = overlays;}
        nixos-wsl.nixosModules.default
        ./system/wsl-work.nix
        home-manager.nixosModules.home-manager
        (hmConfig "nixos" ./home-manager/wsl-work.nix)
      ];
    };
  };
}
