{
  config,
  pkgs,
  lib,
  nixvim,
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
    tmux
    tmuxinator
    # azure-cli
    # azure-cli-extensions.azure-devops
    (azure-cli.withExtensions [
      azure-cli-extensions.azure-devops
    ])
    fzf
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
    sqlcmd
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

  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        # The 'theme' attribute set defines all the colors
        theme = {
          # General UI Colors
          activeBorderColor = ["#89b4fa" "bold"]; # Blue (active panel border)
          inactiveBorderColor = ["#a6adc8"]; # Gray (inactive panel borders)
          optionsTextColor =
            #["#cbdbf5"];
            ["#89b4fa"]; # Blue (help menu options)
          selectedLineBgColor = ["#313244"]; # Dark gray (selected line background)
          defaultFgColor = ["#cdd6f4"]; # White (default text color)

          # Specific Git Status Colors
          unstagedChangesColor = ["#f38ba8"]; # Pink/Red (unstaged files)
          stagedChangesColor = ["#fae3b0"]; # Yellow (staged files)
          trackedFgColor = ["#a6da95"]; # Green (tracked files)

          # Commit colors
          cherryPickedCommitBgColor = ["#45475a"]; # Darker gray (cherry-picked commit background)
          cherryPickedCommitFgColor = ["#89b4fa"]; # Blue (cherry-picked commit foreground)

          # Searching
          searchingActiveBorderColor = ["#f9e2af"]; # Yellow (active border when searching)
        };
      };
    };
  };

  # home.file.".vimrc".source = ./vim_configuration;

  programs.home-manager.enable = true;

  programs.brave = {
    enable = true;
    extensions = [
      # vimium
      "dbepggeogbaibhgnhhndojpepiihcmeb"
      # macos passwords for chrome
      "pejdijmoenmkgeppbflobdenhhabjlaj"
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
