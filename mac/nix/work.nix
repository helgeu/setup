{
  config,
  pkgs,
  lib,
  nixvim,
  #vscode-marketplace,
  ...
}: let
  combinedDotnet = with pkgs.dotnetCorePackages;
    combinePackages [
      sdk_8_0
      sdk_9_0
      sdk_10_0
      runtime_8_0
    ];
in {
  imports = [
    ./git.nix
    ./iterm2.nix
    ./zsh.nix
    #./nixvim.nix
    ./nvf.nix
  ];

  home.username = "helgereneurholm";
  home.homeDirectory = "/Users/helgereneurholm";

  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    git
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
    git-credential-manager
    #  pkgs.powershell
    pandoc
    fnm
    direnv
    eza
    delta
    pkgs.nixfmt-rfc-style
    fd
    ripgrep
    jetbrains.rider
    alt-tab-macos
  ];

  home.sessionVariables = {
    #EDITOR = "nvim";
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

  programs.lsd = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.vscode = {
    enable = true;
    profiles.default.userSettings = {
      "editor.fontFamily" = "'MesloLGM Nerd Font','MesloLGS Nerd Font','MesloLGL Nerd Font', Menlo, Monaco, 'Courier New', monospace";
      "terminal.integrated.fontFamily" = "MesloLGM Nerd Font";
      "editor.fontLigatures" = true;
      "chat.agent.enabled" = true;
    };
    # programs.vscode.profiles.default.extensions
    profiles.default.extensions = with pkgs; [
      vscode-extensions."42crunch".vscode-openapi
      vscode-extensions.ionide.ionide-fsharp
      vscode-extensions.hediet.vscode-drawio
      vscode-extensions.chrischinchilla.vscode-pandoc
      vscode-extensions.bierner.markdown-mermaid
      vscode-extensions.ms-dotnettools.csdevkit
      vscode-extensions.jnoortheen.nix-ide
    ];
  };

  # home.file.".vimrc".source = ./vim_configuration;

  programs.home-manager.enable = true;

  programs.brave = {
    enable = true;
    extensions = [
      "dbepggeogbaibhgnhhndojpepiihcmeb"
    ];
  };

  #programs.chromium = {
  #  enable = true;
  #  #package = pkgs.chromium;
  #  package = pkgs.brave;
  #  extensions = [
  #    # vimium: https://chromewebstore.google.com/detail/dbepggeogbaibhgnhhndojpepiihcmeb?utm_source=item-share-cb
  #    "dbepggeogbaibhgnhhndojpepiihcmeb"
  #  ];
  #  #commandLineArgs = [
  #  #];
  #};
}
