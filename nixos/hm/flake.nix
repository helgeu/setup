{
 description = "Home Manager config"; #You can change this to whatever

 inputs = {
   # Nixpkgs
   nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

   # Home manager
   home-manager = 
    {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

   # Hardware
   hardware.url = "github:nixos/nixos-hardware";
   nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
 };

 outputs = { self, nixpkgs, home-manager, nixos-wsl, ... }@inputs: {
   # NixOS configuration entrypoint
   # Available through 'nixos-rebuild --flake .#your-hostname'

   nixosConfigurations = {
     # FIXME replace with your hostname
     nixos = nixpkgs.lib.nixosSystem {
       system = "x86_64-linux";
       specialArgs = { inherit inputs; }; # Pass flake inputs to our config
       # > Our main nixos configuration file <
       modules = [
         nixos-wsl.nixosModules.default
         {
           system.stateVersion = "25.05";
           wsl.enable = true;
         }
         ./nixos/configuration.nix
       ];
     };
   };

   # home-manager configuration entrypoint
   # Available through 'home-manager --flake .#your-username@your-hostname'
   homeConfigurations = {
     # FIXME replace with your username@hostname
     "nixos@nixos" = home-manager.lib.homeManagerConfiguration {
       pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
       extraSpecialArgs = { inherit inputs; }; # Pass flake inputs to our config
       # > Our main home-manager configuration file <
       modules = [ 
           ./home-manager/home.nix 
           ./zsh/zsh.nix
           ./git/git.nix
           ];
     };
   };
 };
}

