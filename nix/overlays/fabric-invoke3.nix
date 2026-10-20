# WORKAROUND (all platforms): azure-cli does not evaluate.
#
# nixpkgs bumped python invoke to 3.x. fabric 3.2.3 does not support invoke 3
# (https://github.com/fabric/fabric/issues/2376), so nixpkgs marks fabric as
# broken when invoke >= 3. azure-cli depends on fabric: it imports
# `from fabric import Connection` in command_modules/appservice/custom.py.
#
# Upstream fabric already fixed this in commit 7fa309db ("Update some classes
# to handle Invoke 3.x changes"), but no release contains it yet. Backport that
# commit to fabric and clear the broken flag. Only fabric changes, so nothing
# else in the python set rebuilds.
#
# TODO: remove when a fabric release includes 7fa309db and nixpkgs ships it.
_final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (_pyFinal: pyPrev: {
      fabric = pyPrev.fabric.overridePythonAttrs (old: {
        patches = (old.patches or [ ]) ++ [
          (prev.fetchpatch {
            name = "fabric-invoke-3.patch";
            url = "https://github.com/fabric/fabric/commit/7fa309db9dd5dac69079c1fb83b6f579555f7d53.patch";
            hash = "sha256-HxdV1XbsytBYOHV8WqcpKMpqGRkbXD/UlmAFSrmsFTg=";
          })
        ];
        # The released setup.py still pins invoke<3.0 (the upstream bump is
        # also unreleased).
        pythonRelaxDeps = (old.pythonRelaxDeps or [ ]) ++ [ "invoke" ];
        meta = old.meta // {
          broken = false;
        };
      });
    })
  ];
}
