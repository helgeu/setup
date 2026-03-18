{ pkgs, claude-code, ... }:
let
  lspServers = import ./lsp-servers.nix { inherit pkgs; };
in {
  home.packages = [
    claude-code.packages.${pkgs.stdenv.hostPlatform.system}.default
  ] ++ lspServers.packages;

  programs.rtk = {
    enable = true;
    claudeCode = {
      enable = true;
      baseClaude = ./claude/CLAUDE.md.template;
      baseSettings = ./claude/settings.json;
    };
  };

  home.file.".claude/.lsp.json".source = lspServers.claudeLspJson;
  home.file.".claude/ado_cli_reference.md".source = ./claude/ado_cli_reference.md;
}
