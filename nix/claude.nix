{ pkgs, claude-code, ... }:
let
  lspServers = import ./lsp-servers.nix { inherit pkgs; };
in {
  home.packages = [
    claude-code.packages.${pkgs.stdenv.hostPlatform.system}.default
  ] ++ lspServers.packages;

  home.file.".claude/CLAUDE.md".source = ./claude/CLAUDE.md;
  home.file.".claude/settings.json".source = ./claude/settings.json;
  home.file.".claude/.lsp.json".source = lspServers.claudeLspJson;
}
