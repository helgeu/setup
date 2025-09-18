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

  programs.zsh = {
    enable = true;
    shellAliases = {
        switch = "darwin-rebuild switch --flake ~/git/github/setup/mac/nix";
	dir = "ls -al";
	sudo = "sudo ";
    };

    enableCompletion = true;
    syntaxHighlighting.enable = true;

    initContent = ''
		eval "$(oh-my-posh init zsh)"
    '';
  };
  programs.vscode = {
    # programs.vscode.profiles.default.extensions
    profiles.default.extensions = with pkgs; [
      42crunch.vscode-openapi
      ionide.ionide-fsharp
      ms-azure-devops.azure-pipelines
      ms-azuretools.vscode-azurefunctions
      ms-azuretools.vscode-azureresourcegro
      ms-azuretools.vscode-azurestorage
      ms-azuretools.vscode-bicep
      ms-azuretools.vscode-docker
      ms-dotnettools.csdevkit
      ms-vscode.powershell
      hediet.vscode-drawio
      devcycles.contextive
      ChrisChinchilla.vscode-pandoc
      bierner.markdown-mermaid
    ];
  };
  home.file.".vimrc".source = ./vim_configuration;


  programs.home-manager.enable = true;

  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      # vimium: https://chromewebstore.google.com/detail/dbepggeogbaibhgnhhndojpepiihcmeb?utm_source=item-share-cb
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # ublock origin
    ];
    commandLineArgs = [
    ];
  };

}
