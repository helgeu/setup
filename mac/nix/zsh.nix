{ config, pkgs, ... }:
{
  programs = {
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting = {
        enable = true;
      };
      shellAliases = {
        ls = "eza -la";
        switch = "darwin-rebuild switch --flake ~/git/github/setup/mac/nix";
        dir = "ls";
        sudo = "sudo ";

      };
      # oh-my-zsh = {
      #   enable = true;
      #   plugins = ["git" "z" "fzf"];
      #   theme = "catppuccin";
      # };
      initContent = "
        # Nix profile to get paths right
        if [ -e \"$HOME/.nix-profile/etc/profile.d/nix.sh\" ]; then
          . \"$HOME/.nix-profile/etc/profile.d/nix.sh\"
        fi

        # Dotnet tools
        #path+=('/home/nixos/.dotnet/tools')

        # Rancher desktop path
        path+=('/Users/helgereneurholm/.rd/bin')

        # fnm
        export PATH=$HOME/.fnm:$PATH
        eval \"$(fnm env --use-on-cd)\"

        # Direnv
        eval \"$(direnv hook zsh)\"

        # Oh my posh
        eval \"$(oh-my-posh init zsh --config 'https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/themes/lambdageneration.omp.json')\"
        #eval \"$(oh-my-posh init zsh --config 'https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/themes/catpuccin.omp.json')\"
        #eval \"$(oh-my-posh init zsh --config 'https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/themes/tokyonight_storm.omp.json')\"        
        #eval \"$(oh-my-posh init zsh)\"

";
    };
  };
}
