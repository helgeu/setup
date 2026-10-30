# Vale prose linter with a global base configuration.
#
# Installs vale and links a complete config directory to ~/.config/vale:
#   .vale.ini     English: Vale + Microsoft + Formatting
#   vale-nb.ini   Norwegian Bokmal: Formatting + NB (Hunspell nb_NO)
#   styles/       Microsoft (pinned release), Formatting and NB (SuperOffice,
#                 MIT) and the nb_NO dictionary.
#
# No project vocabulary lives here. vale-check adds vocabularies from the
# current repository (.vale/vocabularies) or from --vocab DIR.
#
# The nb_NO dictionary is GPL-2.0. Nix downloads it at build time, so the
# dictionary files are not stored in this repository.
#
# Run it with ~/bin/vale-check. See ai/shared/vale-readability-reference.md.
{ pkgs, ... }:
let
  microsoftStyle = pkgs.fetchzip {
    url = "https://github.com/errata-ai/Microsoft/archive/refs/tags/v0.15.1.tar.gz";
    hash = "sha256-MycWukXoeTZzGAcoNODzt592VHWgjnMXZdNPoQWDC18=";
  };

  dictionaryNb = pkgs.fetchurl {
    url = "https://registry.npmjs.org/dictionary-nb/-/dictionary-nb-3.0.0.tgz";
    hash = "sha256-SPj2kOKG7bb35VFwrtxalE1k1LN0y8ELxFTD6p5z1vA=";
  };

  valeConfig = pkgs.runCommand "vale-config" { } ''
    mkdir -p $out/styles/config/dictionaries
    cp ${./vale.ini} $out/.vale.ini
    cp ${./vale-nb.ini} $out/vale-nb.ini
    cp -r ${microsoftStyle}/Microsoft $out/styles/Microsoft
    cp -r ${./styles/Formatting} $out/styles/Formatting
    cp -r ${./styles/NB} $out/styles/NB
    tar -xzf ${dictionaryNb} -C "$TMPDIR"
    cp "$TMPDIR/package/index.aff" $out/styles/config/dictionaries/nb_NO.aff
    cp "$TMPDIR/package/index.dic" $out/styles/config/dictionaries/nb_NO.dic
  '';
in
{
  home.packages = [ pkgs.vale ];

  xdg.configFile."vale".source = valeConfig;
}
