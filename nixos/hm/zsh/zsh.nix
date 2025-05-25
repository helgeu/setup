{ config, pkgs, ... }: {
  programs = {
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting = {
        enable = true;
      };
      shellAliases = {
      	ls="eza -la";
      };
      initContent = "
        # Nix profile to get paths right
        if [ -e \"$HOME/.nix-profile/etc/profile.d/nix.sh\" ]; then
          . \"$HOME/.nix-profile/etc/profile.d/nix.sh\"
        fi

        # Dotnet tools
        path+=('$HOME/.dotnet/tools')

        # fnm
        export PATH=$HOME/.fnm:$PATH
        eval \"$(fnm env --use-on-cd)\"

        # Direnv
        eval \"$(direnv hook zsh)\"

        # Oh my posh
        eval \"$(oh-my-posh init zsh --config 'https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/themes/lambdageneration.omp.json')\"

";
    };
  };
}