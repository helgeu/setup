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
    ./vscode.nix
  ];

  home.username = "helgereneurholm";
  home.homeDirectory = "/Users/helgereneurholm";

  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    git
    tmux
    tmuxinator
    # azure-cli
    # azure-cli-extensions.azure-devops
    (azure-cli.withExtensions [
      azure-cli-extensions.azure-devops
    ])
    fzf
    lazygit
    combinedDotnet
    azure-functions-core-tools
    bicep
    oh-my-posh
    zip
    git-credential-manager
    powershell
    pandoc
    fnm
    direnv
    eza
    delta
    nixfmt-rfc-style
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
  #enable = true;
  #package = pkgs.powershell;
  #profile = ''
  # Your PowerShell profile content here
  #oh-my-posh init pwsh --config 'https://github.com/jandedobbeleer/oh-my-posh/main/themes/lambdageneration.omp.json' | Invoke-Expression
  #'';
  #};

  programs.lsd = {
    enable = true;
    enableZshIntegration = true;
  };

  # home.file.".vimrc".source = ./vim_configuration;

  programs.home-manager.enable = true;

  programs.brave = {
    enable = true;
    extensions = [
      "dbepggeogbaibhgnhhndojpepiihcmeb"
    ];
    commandLineArgs = [
      "--disable-features=PasswordManagerOnboarding"
      "--disable-features=AutofillEnableAccountWalletStorage"
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
