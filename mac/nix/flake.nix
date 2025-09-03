# ~/.config/nix/flake.nix

{
  description = "Initial MacOs setup";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
        url = "github:LnL7/nix-darwin";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = {pkgs, lib, ... }: {

        nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
             "vscode"
          ];
        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility. please read the changelog
        # before changing: `darwin-rebuild changelog`.
        system.stateVersion = 5;

        # The platform the configuration will be used on.
        # If you're on an Intel system, replace with "x86_64-darwin"
        nixpkgs.hostPlatform = "aarch64-darwin";

        # Declare the user that will be running `nix-darwin`.
        users.users."$USER" = {
            name = "$USER";
            home = "/Users/$USER";
        };

        # Create /etc/zshrc that loads the nix-darwin environment.
        programs.zsh.enable = true;

        environment.systemPackages = [
            pkgs.vscode
            pkgs.brave
            pkgs.firefox
            pkgs.git-credential-manager
	];
    };
  in
  {
    darwinConfigurations.X-GLV6Y9N492 = nix-darwin.lib.darwinSystem {
      modules = [
         configuration
      ];
    };
  };
}
