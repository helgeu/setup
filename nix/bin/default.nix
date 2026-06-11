# User scripts installed into ~/bin on every machine.
#
# To add a new personal script: drop the file in this directory and add a
# matching `home.file."bin/<name>"` entry below. Everything here is symlinked
# into ~/bin (read-only) and ~/bin is put on PATH for all hosts.
{ ... }:
{
  home.file = {
    "bin/azprs" = {
      source = ./azprs;
      executable = true;
    };
    "bin/oc" = {
      source = ./oc;
      executable = true;
    };
    "bin/pr-review" = {
      source = ./pr-review;
      executable = true;
    };
    "bin/pr-review-post" = {
      source = ./pr-review-post;
      executable = true;
    };
  };

  # Ensure ~/bin is on PATH everywhere.
  home.sessionPath = [ "$HOME/bin" ];
}
