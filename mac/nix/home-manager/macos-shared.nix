# Shared macOS-specific home-manager configuration
{
  pkgs,
  lib,
  ...
}: let
  defaultBrowserBundleId = "com.brave.Browser";
in {
  imports = [
    ../iterm2.nix
    ../ghostty.nix
  ];

  # Set Brave as default browser after installation
  home.activation.setDefaultBrowser = lib.hm.dag.entryAfter ["writeBoundary"] ''
    run ${pkgs.duti}/bin/duti -s ${defaultBrowserBundleId} http || true
    run ${pkgs.duti}/bin/duti -s ${defaultBrowserBundleId} https || true
  '';

  # macOS-specific packages
  home.packages = with pkgs; [
    duti # Required for default browser activation
    iterm2
  ];
}
