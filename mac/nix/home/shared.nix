{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../git.nix
    ../zsh.nix
    ../nvf.nix
    ../vscode.nix
    ../claude.nix
  ];

  # Shared packages
  home.packages = with pkgs; [
    # Shell tools
    tmux
    fzf
    eza
    delta
    fd
    ripgrep
    direnv

    # Dev tools
    oh-my-posh
    pandoc
    powershell
    nixfmt
    gitleaks

    # Git
    git-credential-manager
  ];

  home.sessionVariables = {
    MANPAGER = "nvim +Man!";
  };

  programs.home-manager.enable = true;

  programs.lsd = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = false;
    settings = {
      git_protocol = "ssh";
      editor = "nvim";
    };
  };

  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        theme = {
          activeBorderColor = ["#89b4fa" "bold"];
          inactiveBorderColor = ["#a6adc8"];
          optionsTextColor = ["#89b4fa"];
          selectedLineBgColor = ["#313244"];
          defaultFgColor = ["#cdd6f4"];
          unstagedChangesColor = ["#f38ba8"];
          stagedChangesColor = ["#fae3b0"];
          trackedFgColor = ["#a6da95"];
          cherryPickedCommitBgColor = ["#45475a"];
          cherryPickedCommitFgColor = ["#89b4fa"];
          searchingActiveBorderColor = ["#f9e2af"];
        };
      };
    };
  };

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
}
