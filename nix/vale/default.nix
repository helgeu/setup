# Vale prose linter with a global base configuration.
#
# Installs vale and links a complete config directory to ~/.config/vale:
#   .vale.ini     English: Vale + Microsoft + Formatting
#   vale-nb.ini   Norwegian Bokmal: Formatting + NB (Hunspell nb_NO)
#   vale-commit.ini  Commit messages: Commits + Conventional (vale-commit)
#   styles/       Microsoft and Commits (pinned releases), Formatting and NB
#                 (SuperOffice, MIT) and the nb_NO dictionary.
#
# No project vocabulary lives here. vale-check adds vocabularies from the
# current repository (.vale/vocabularies) or from --vocab DIR.
#
# The nb_NO dictionary is GPL-2.0. Nix downloads it at build time, so the
# dictionary files are not stored in this repository.
#
# Run it with ~/bin/vale-check, and check commit messages with
# ~/bin/vale-commit. See ai/shared/vale-readability-reference.md.
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

  # Commit message styles and the View that splits a message into subject,
  # body and trailers (jdkato/commits, MIT).
  commitsPackage = pkgs.fetchurl {
    url = "https://github.com/jdkato/commits/releases/download/v0.2.0/Commits.zip";
    hash = "sha256-7Tg80iM9JMpyXkVG+jpR4+hWhJBsYUIN+SRqyImlLjk=";
  };

  valeConfig = pkgs.runCommand "vale-config" { nativeBuildInputs = [ pkgs.unzip ]; } ''
    mkdir -p $out/styles/config/dictionaries
    cp ${./vale.ini} $out/.vale.ini
    cp ${./vale-nb.ini} $out/vale-nb.ini
    cp ${./vale-commit.ini} $out/vale-commit.ini
    cp -r ${microsoftStyle}/Microsoft $out/styles/Microsoft
    unzip -q ${commitsPackage} -d "$TMPDIR/commits"
    cp -r "$TMPDIR/commits/Commits/styles/." $out/styles/
    cp -r ${./styles/Formatting} $out/styles/Formatting
    cp -r ${./styles/NB} $out/styles/NB
    tar -xzf ${dictionaryNb} -C "$TMPDIR"
    cp "$TMPDIR/package/index.aff" $out/styles/config/dictionaries/nb_NO.aff
    # Vale cannot parse entries with an empty flag list ("og/"), and then
    # flags common words. Remove the trailing slash.
    sed 's#/$##' "$TMPDIR/package/index.dic" > $out/styles/config/dictionaries/nb_NO.dic
  '';
in
{
  home.packages = [ pkgs.vale ];

  xdg.configFile."vale".source = valeConfig;
}
