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
    # NOTE: taps are mutable (managed by `brew`); package versions are upgraded
    # via scripts/update.sh (brew upgrade --greedy), not the flake. Do not add
    # homebrew-core/homebrew-cask inputs unless you also wire nix-homebrew.taps
    # with mutableTaps = false.
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

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
    nvf,
    ...
  }: let
    darwinSystem = "aarch64-darwin";
    linuxSystem = "x86_64-linux";

    overlays = [
      inputs.nix-vscode-extensions.overlays.default
      (import ./overlays/bicep-protoc.nix)
      (import ./overlays/opencode-bun-splitting.nix)
    ];

    # Shared home-manager config for all platforms
    hmConfig = user: homeModule: {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.verbose = true;
      home-manager.backupFileExtension = "backup";
      home-manager.extraSpecialArgs = {
        claude-code = inputs.claude-code;
      };
      home-manager.users.${user} = {...}: {
        imports = [
          homeModule
          nvf.homeManagerModules.default
          inputs.rtk.homeManagerModules.default
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

    # Helper to create a NixOS-WSL configuration
    mkWsl = {
      systemModule,
      homeModule,
    }:
      nixpkgs.lib.nixosSystem {
        system = linuxSystem;
        modules = [
          {nixpkgs.overlays = overlays;}
          nixos-wsl.nixosModules.default
          systemModule
          home-manager.nixosModules.home-manager
          (hmConfig "nixos" homeModule)
        ];
      };
  in {
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
    nixosConfigurations."wsl-work" = mkWsl {
      systemModule = ./system/wsl-work.nix;
      homeModule = ./home-manager/wsl-work.nix;
    };

    # WSL: IMDI-computer
    nixosConfigurations."IMDI-computer" = mkWsl {
      systemModule = ./system/IMDI-computer.nix;
      homeModule = ./home-manager/IMDI-computer.nix;
    };
  };
}
