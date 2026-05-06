{ pkgs, ... }:
let
  lspServers = import ../../lsp-servers.nix { inherit pkgs; };
in {
  programs.rtk.claudeCode = {
    enable = true;
    baseSettings = ./settings.json;
  };

  home.file.".claude/.lsp.json".source = lspServers.claudeLspJson;
  home.file.".claude/statusline-command.sh".source = ./statusline-command.sh;
}
