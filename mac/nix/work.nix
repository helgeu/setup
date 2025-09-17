{
  config,
  pkgs,
  lib,
  ...
}: let
  combinedDotnet = with pkgs.dotnetCorePackages;
    combinePackages [
      sdk_8_0
      sdk_9_0
      runtime_8_0	
    ];
in {
  home.username = "helgereneurholm";
  home.homeDirectory = "/Users/helgereneurholm";

  home.stateVersion = "25.05";

  home.packages = [
    pkgs.git
    pkgs.neovim
    pkgs.zsh
    pkgs.unzip # Unzip for Mason LSPs and stuff
    pkgs.tmux
    pkgs.tmuxinator
  #  pkgs.azure-cli
    pkgs.fzf
    pkgs.lazygit
    combinedDotnet
    pkgs.azure-functions-core-tools
    pkgs.bicep
    pkgs.oh-my-posh
    pkgs.zip
    pkgs.bruno
    pkgs.git-credential-manager
    pkgs.powershell
    pkgs.oh-my-posh
    # pkgs.brave
    pkgs.vscode
    pkgs.telegram-desktop
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    DOTNET_ROOT = "${combinedDotnet}/share/dotnet";
    MANPAGER = "nvim +Man!";
  };

  programs.powershell = {
        enable = true;
        profile = ''
          # Your PowerShell profile content here
	  oh-my-posh init pwsh --config 'https://github.com/jandedobbeleer/oh-my-posh/main/themes/lambdageneration.omp.json' | Invoke-Expression
        '';
      };

  programs.zsh = {
    enable = true;
    shellAliases = {
        switch = "darwin-rebuild switch --flake ~/git/github/setup/mac/nix";
	dir = "ls -al";
    };
  };

  home.file.".vimrc".source = ./vim_configuration;


  programs.home-manager.enable = true;

  #programs.chromium = {
  #  enable = true;
  #  package = pkgs.brave;
  #  extensions = [
  #    # vimium: https://chromewebstore.google.com/detail/dbepggeogbaibhgnhhndojpepiihcmeb?utm_source=item-share-cb
  #    { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # ublock origin
  #  ];
  #  commandLineArgs = [
  #  ];
  #};
}
