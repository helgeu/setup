{
  config,
  pkgs,
  lib,
  ...
}: let
  isDarwin = pkgs.stdenv.isDarwin;
in {
  programs = {
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting = {
        enable = true;
      };
      shellAliases = {
        dir = "ls -al";
        sudo = "sudo ";
      };
      initContent = ''
        # Nix profile to get paths right
        if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
          . "$HOME/.nix-profile/etc/profile.d/nix.sh"
        fi

        ${lib.optionalString isDarwin ''
        # Rancher desktop path (macOS only)
        path+=("${config.home.homeDirectory}/.rd/bin")
        ''}

        # fnm
        export PATH=$HOME/.fnm:$PATH
        eval "$(fnm env --use-on-cd)"

        # Direnv
        eval "$(direnv hook zsh)"

        # Oh my posh
        eval "$(oh-my-posh init zsh --config 'https://raw.githubusercontent.com/helgeu/setup/refs/heads/main/mac/nix/hru-powerlevel10k_rainbow.omp.json')"
      '';
    };
  };
}
