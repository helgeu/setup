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

  # Brave External Extensions (triggers installation prompt on browser start)
  # This is the fallback method since ExtensionSettings policy in CustomUserPreferences
  # doesn't work on macOS (Brave reads policies from /Library/Managed Preferences/)
  home.file = {
    # Vimium
    "Library/Application Support/BraveSoftware/Brave-Browser/External Extensions/dbepggeogbaibhgnhhndojpepiihcmeb.json".text = builtins.toJSON {
      external_update_url = "https://clients2.google.com/service/update2/crx";
    };
    # iCloud Passwords
    "Library/Application Support/BraveSoftware/Brave-Browser/External Extensions/pejdijmoenmkgeppbflobdenhhabjlaj.json".text = builtins.toJSON {
      external_update_url = "https://clients2.google.com/service/update2/crx";
    };
  };
}
