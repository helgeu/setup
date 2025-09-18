{
  config,
  pkgs,
  lib,
  vscode-marketplace,
  ...
}: let
  combinedDotnet = with pkgs.dotnetCorePackages;
    combinePackages [
      sdk_8_0
      sdk_9_0
      runtime_8_0	
    ];
in {

	imports = [
		./git.nix
		./zsh.nix
	];
  home.username = "helgereneurholm";
  home.homeDirectory = "/Users/helgereneurholm";

  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    git
    neovim
    tmux
    tmuxinator
  #  azure-cli
    fzf
    lazygit
    combinedDotnet
    azure-functions-core-tools
    bicep
    oh-my-posh
    zip
    bruno
    git-credential-manager
  #  pkgs.powershell 
    pandoc
    fnm
    direnv
    eza
    delta
    ];

  home.sessionVariables = {
    EDITOR = "nvim";
    DOTNET_ROOT = "${combinedDotnet}/share/dotnet";
    MANPAGER = "nvim +Man!";
  };

  #programs.powershell = {
  #      enable = true;
  #      profile = ''
  #        # Your PowerShell profile content here
  #	oh-my-posh init pwsh --config 'https://github.com/jandedobbeleer/oh-my-posh/main/themes/lambdageneration.omp.json' | Invoke-Expression
  #      '';
  #};
  programs.vscode = {
    enable = true;
    # programs.vscode.profiles.default.extensions
    profiles.default.extensions = with pkgs.vscode-extensions; [
      #42crunch.vscode-openapi
      ionide.ionide-fsharp
      hediet.vscode-drawio
      #ChrisChinchilla.vscode-pandoc
      bierner.markdown-mermaid
      ms-dotnettools.csdevkit
    ];
  };

  home.file.".vimrc".source = ./vim_configuration;


  programs.home-manager.enable = true;

  programs.chromium = {
    enable = true;
    #package = pkgs.chromium;
    package = pkgs.brave;
    extensions = [
      # vimium: https://chromewebstore.google.com/detail/dbepggeogbaibhgnhhndojpepiihcmeb?utm_source=item-share-cb
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # ublock origin
    ];
    commandLineArgs = [
    ];
  };

}
