{
  config,
  pkgs,
  lib,
  adoboards,
  ...
}: let
  combinedDotnet = with pkgs.dotnetCorePackages;
    combinePackages [
      sdk_8_0
      sdk_9_0
      sdk_10_0
      runtime_8_0
    ];
  defaultBrowserBundleId = "com.brave.Browser";
in {
  imports = [
    ./shared.nix
    ../iterm2.nix
    ../adoboards-config.nix
  ];

  home.username = "helgereneurholm";
  home.homeDirectory = "/Users/helgereneurholm";
  home.stateVersion = "25.11";

  # Set default browser after Brave is installed
  home.activation.setDefaultBrowser = lib.hm.dag.entryAfter ["writeBoundary"] ''
    run ${pkgs.duti}/bin/duti -s ${defaultBrowserBundleId} http || true
    run ${pkgs.duti}/bin/duti -s ${defaultBrowserBundleId} https || true
  '';

  # Work-specific packages
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

    # Azure / Cloud
    (azure-cli.withExtensions [
      azure-cli-extensions.azure-devops
      azure-cli-extensions.resource-graph
      azure-cli-extensions.application-insights
    ])
    azure-functions-core-tools
    bicep

    # .NET development
    combinedDotnet
    omnisharp-roslyn
    fsautocomplete

    # JetBrains
    jetbrains.rider

    # JS/Node
    fnm
    pnpm

    # Database
    sqlcmd

    # Utilities
    tmuxinator
    zip
    alt-tab-macos
    iterm2
    nil

    # Azure DevOps TUI
    adoboards.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  home.sessionVariables = {
    DOTNET_ROOT = "${combinedDotnet}/share/dotnet";
  };

}
