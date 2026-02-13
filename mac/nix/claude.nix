{ config, pkgs, claude-code, ... }:
{
  home.packages = [
    claude-code.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
  home.file.".claude/CLAUDE.md".source = ./claude/CLAUDE.md;
}
