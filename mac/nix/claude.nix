{ pkgs, claude-code, ... }:
{
  home.packages = [ claude-code.packages.${pkgs.stdenv.hostPlatform.system}.default ];
  home.file.".claude/CLAUDE.md".source = ./claude/CLAUDE.md;
  home.file.".claude/settings.json".source = ./claude/settings.json;
}
