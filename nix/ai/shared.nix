{ pkgs, claude-code, ... }:
let
  lspServers = import ../lsp-servers.nix { inherit pkgs; };
in {
  home.packages = [
    claude-code.packages.${pkgs.stdenv.hostPlatform.system}.default
    pkgs.opencode
  ] ++ lspServers.packages;

  programs.rtk = {
    enable = true;
    claudeCode.baseClaude = ./shared/CLAUDE.md.template;
  };
}
