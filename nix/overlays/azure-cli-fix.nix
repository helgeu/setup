# TEMPORARY WORKAROUND - Remove when PR is merged
#
# Issue: https://github.com/NixOS/nixpkgs/issues/497475
# PR:    https://github.com/NixOS/nixpkgs/pull/497478
#
# Problem: azure-cli-extensions.application-insights requires isodate~=0.6.0
#          but nixpkgs has isodate 0.7.2
#
# To check if fixed: nix build nixpkgs#azure-cli-extensions.application-insights
# If it builds, delete this file and remove from flake.nix
final: prev: {
  azure-cli-extensions = prev.azure-cli-extensions // {
    application-insights = prev.azure-cli-extensions.application-insights.overridePythonAttrs (old: {
      pythonRelaxDeps = (old.pythonRelaxDeps or []) ++ ["isodate"];
    });
  };
}
