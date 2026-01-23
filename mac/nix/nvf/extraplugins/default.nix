# Aggregates all extra plugins for NVF
# Each plugin file should return an attrset with plugin definitions
{
  pkgs,
  ...
}: let
  adoboards = import ./adoboards.nix {inherit pkgs;};
in
  # Merge all plugin attribute sets
  adoboards
  # Future plugins can be added here:
  # // otherplugin
