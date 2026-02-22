{ pkgs, ... }: {
  imports = [
    ./shared.nix
    ./macos-shared.nix
    ./work-tools.nix
  ];

  home.username = "helgereneurholm";
  home.homeDirectory = "/Users/helgereneurholm";
  home.stateVersion = "25.11";

  # Work Mac-specific packages
  home.packages = with pkgs; [
    # iTerm2 Python CLI
    (pkgs.python313.withPackages (ps: [
      (ps.buildPythonPackage rec {
        pname = "it2";
        version = "0.2.3";
        pyproject = true;
        src = pkgs.fetchPypi {
          inherit pname version;
          hash = "sha256:3d47f802ccd6da56b134dc6c7affb01f29eb40c26d9c91f9c80f25a431981d54";
        };
        build-system = [ps.hatchling];
        nativeBuildInputs = [ps.pythonRelaxDepsHook];
        pythonRelaxDeps = true;
        dependencies = with ps; [click iterm2 pyyaml rich];
        doCheck = false;
      })
    ]))
  ];
}
