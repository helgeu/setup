{
  config,
  pkgs,
  lib,
  ...
}: let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;
  combinedDotnet = with pkgs.dotnetCorePackages;
    combinePackages [
      sdk_8_0
      sdk_9_0
      sdk_10_0
      runtime_8_0
    ];
in {
  imports = [
    ../git.nix
    ../zsh.nix
    ../nvf.nix
    ../vscode.nix
    ../claude.nix
  ];

  # Shared packages (cross-platform)
  home.packages = with pkgs; [
    # .NET development
    combinedDotnet
    # Shell tools
    tmux
    fzf
    eza
    delta
    fd
    ripgrep
    direnv

    # JS/Node
    fnm

    # Dev tools
    oh-my-posh
    pandoc
    texliveBasic  # Needed for pandoc PDF output
    powershell
    nixfmt
    gitleaks

    # Git
    git-credential-manager
  ] ++ lib.optionals isDarwin [
    # macOS-only
    xcodegen  # Swift project generation
    alt-tab-macos
  ];

  home.sessionVariables = {
    MANPAGER = "nvim +Man!";
    DOTNET_ROOT = "${combinedDotnet}/share/dotnet";
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

  # Brave extension management via External Extensions JSON
  # Path differs: macOS uses "Library/Application Support/", Linux uses ".config/"
  # iCloud Passwords extension only works on macOS
  home.file = let
    braveExtPath = id:
      if isDarwin
      then "Library/Application Support/BraveSoftware/Brave-Browser/External Extensions/${id}.json"
      else ".config/BraveSoftware/Brave-Browser/External Extensions/${id}.json";
    extConfig = {
      external_update_url = "https://clients2.google.com/service/update2/crx";
    };
  in {
    # Vimium (all platforms)
    "${braveExtPath "dbepggeogbaibhgnhhndojpepiihcmeb"}".text = builtins.toJSON extConfig;
  } // lib.optionalAttrs isDarwin {
    # iCloud Passwords (macOS only)
    "${braveExtPath "pejdijmoenmkgeppbflobdenhhabjlaj"}".text = builtins.toJSON extConfig;
  };
}
