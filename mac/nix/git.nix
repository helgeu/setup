{
  config,
  pkgs,
  ...
}: {
  home.file."githooks/pre-commit" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      gitleaks protect --staged --no-banner
      if [ $? -ne 0 ]; then
        echo "gitleaks: secrets detected in staged changes. Commit blocked."
        exit 1
      fi
    '';
  };

  programs = {
    git = {
      enable = true;
      package = pkgs.git.override {osxkeychainSupport = false;};
      settings = {
        user.email = "helge@urholm.no";
        user.name = "helgereneurholm";

        credential.helper = "manager";
        credential.useHttpPath = true;
        core = {
          commentChar = ";";
          hooksPath = "${config.home.homeDirectory}/githooks";
          pager = "delta";
        };
        push = {
          default = "current";
          autoSetupRemote = true;
        };
        pull = {
          rebase = true;
        };
        rebase = {
          autosquash = true;
        };
        diff = {
          algorithm = "histogram";
          colorMoved = "plain";
          renames = true;
        };
        help = {
          autocorrect = "prompt";
        };
        fetch = {
          prune = true;
          pruneTags = true;
        };
        blame = {
          ignoreRevsFile = ".git-blame-ignore-revs";
        };
        merge = {
          conflictStyle = "zdiff3";
        };
        rerere = {
          enabled = true;
          autoUpdate = true;
        };
        tag = {
          sort = "-version:refname";
        };
      };
    };
  };
}
