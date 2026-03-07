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
        # Nix operations
        nrs = "sudo ~/git/github/setup/nix/scripts/switch.sh";
        nru = "~/git/github/setup/nix/scripts/update.sh";
        nrc = "~/git/github/setup/nix/scripts/check.sh && ~/git/github/setup/nix/scripts/eval.sh";
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

        # fnm (Fast Node Manager)
        if command -v fnm &> /dev/null; then
          export PATH=$HOME/.fnm:$PATH
          eval "$(fnm env --use-on-cd)"
        fi
      '';
    };
  };
}
