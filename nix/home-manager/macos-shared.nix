# Shared macOS-specific home-manager configuration
{
  pkgs,
  lib,
  ...
}: let
  defaultBrowserBundleId = "com.brave.Browser";
in {
  imports = [
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

  # Quick Action: Open Activity Monitor (Ctrl+Shift+Esc)
  # macOS requires .workflow bundles to be real directories (not nix store symlinks)
  home.activation.installActivityMonitorQuickAction = let
    wflow = ../services/open-activity-monitor.wflow;
  in lib.hm.dag.entryAfter ["writeBoundary"] ''
    workflow_dir="$HOME/Library/Services/Open Activity Monitor.workflow/Contents"
    run mkdir -p "$workflow_dir"
    run cp "${wflow}" "$workflow_dir/document.wflow"

    run /usr/bin/defaults write pbs NSServicesStatus \
      -dict-add "com.apple.Automator.Open Activity Monitor - runWorkflowAsService" \
      '{ "key_equivalent" = "^$\U001b"; }'
  '';
}
