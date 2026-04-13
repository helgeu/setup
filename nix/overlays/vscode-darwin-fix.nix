# TEMPORARY WORKAROUND - Remove when upstream fix is merged
#
# Commit: https://github.com/NixOS/nixpkgs/commit/1cbb45d4539c790da33f593c4dade6577ab22e7c
# PR:     https://github.com/NixOS/nixpkgs/pull/509545
#
# Problem: buildVscode generic.nix added glibc.bin, gawk, gnused, which to
#          preFixup PATH without an isLinux guard. On darwin dontFixup=true
#          prevents the script from running, but Nix still evaluates it,
#          triggering glibc's platform assertion on aarch64-darwin.
#
# To check if fixed: nix eval nixpkgs#vscode.preFixup
# If it evaluates without error on darwin, delete this file and remove from flake.nix
final: prev: {
  vscode = prev.vscode.overrideAttrs (old: {
    preFixup =
      if prev.stdenv.hostPlatform.isDarwin
      then ""
      else (old.preFixup or "");
  });
}
