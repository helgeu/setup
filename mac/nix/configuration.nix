{config, pkgs, ...}:
{
          # Necessary for using flakes on this system.
          nix.settings = {
             experimental-features = ["nix-command" "flakes"];
          };
  
          # Used for backwards compatibility. please read the changelog
          # before changing: `darwin-rebuild changelog`.
          system.stateVersion = 5;
  
          # The platform the configuration will be used on.
          # If you're on an Intel system, replace with "x86_64-darwin"
          nixpkgs.hostPlatform = "aarch64-darwin";

	  nixpkgs.config.allowUnfree = true;
  
          # Declare the user that will be running `nix-darwin`.
          users.users.helgereneurholm = {
              name = "helgereneurholm";
              home = "/Users/helgereneurholm";
          };
  
          # Create /etc/zshrc that loads the nix-darwin environment.
          programs.zsh.enable = true;
  
          environment.systemPackages = with pkgs; [ 
	  ];
	  system.primaryUser = "helgereneurholm";
	  system.defaults = {
		finder.AppleShowAllFiles = true;
		NSGlobalDomain = {
			AppleShowScrollBars = "Always";
			"com.apple.keyboard.fnState" = true; # fn by default off
		};

		controlcenter.Bluetooth = true; 
	  };
	  fonts.packages = with pkgs; [
	  	pkgs.nerd-fonts.meslo-lg
		pkgs.nerd-fonts.fira-code
          ];

}
