{ config, pkgs, ... }: {
  programs = {
    git = {
      enable = true;
      
      userName = "Helge Rene Urholm";
      userEmail = "helge@urholm.no";

      # This line may need tweaking but should be somewhat standard given windows and WSL      
      extraConfig.credential.helper = "/mnt/c/Program\\ Files/Git/mingw64/bin/git-credential-manager.exe";
            
      extraConfig = {      
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
