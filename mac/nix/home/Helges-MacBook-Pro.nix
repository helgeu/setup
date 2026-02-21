{
  config,
  pkgs,
  lib,
  ...
}: let
  defaultBrowserBundleId = "com.brave.Browser";
in {
  imports = [
    ./shared.nix
    ../iterm2.nix
  ];

  home.username = "helgeu";
  home.homeDirectory = "/Users/helgeu";
  home.stateVersion = "25.11";

  # Set default browser after Brave is installed
  home.activation.setDefaultBrowser = lib.hm.dag.entryAfter ["writeBoundary"] ''
    run ${pkgs.duti}/bin/duti -s ${defaultBrowserBundleId} http || true
    run ${pkgs.duti}/bin/duti -s ${defaultBrowserBundleId} https || true
  '';

  # Home-specific packages
  home.packages = with pkgs; [
    # Personal/hobby tools
    firefox
    iterm2

    # General utilities
    zip
  ];
}
