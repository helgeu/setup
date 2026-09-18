# Shared macOS-specific home-manager configuration
{
  pkgs,
  lib,
  ...
}: let
  defaultBrowserBundleId = "com.brave.Browser";

  # Brave Shields custom filters — SourcePoint consent-wall bypass.
  # These are the walls (sp_message iframe + sp_veil overlay + scroll-lock) used by
  # Schibsted's Norwegian/Swedish news sites. Managed declaratively here; do NOT edit
  # them in Brave's UI (this list overwrites brave.ad_block.custom_filters on switch).
  #
  # - Generic cosmetic hide catches the wall on any site/subdomain variant.
  # - The scroll-unlock must be per-domain: it's a procedural :style() filter, which
  #   Brave/uBO discard when generic. Domain list is sourced from the maintained
  #   https://github.com/mmsge/schibsted-blokk (verified Schibsted media sites).
  braveScrollUnlock = "html, body:style(overflow: auto !important; height: auto !important; position: static !important; pointer-events: auto !important;)";
  braveConsentDomains = [
    # Norwegian
    "vg.no"
    "vektklubb.no"
    "aftenposten.no"
    "bt.no"
    "aftenbladet.no"
    "e24.no"
    "tek.no"
    "godt.no"
    "minmote.no"
    "shifter.no"
    "tvguide.no"
    # Swedish
    "aftonbladet.se"
    "svd.se"
    "omni.se"
    "omniekonomi.se"
    "klart.se"
  ];
  braveCustomFilters = pkgs.writeText "brave-custom-filters.txt" (''
    ! Managed by nix (home-manager) — edit in macos-shared.nix, NOT in Brave's UI.
    ! SourcePoint consent-wall bypass. Domains: github.com/mmsge/schibsted-blokk
    !
    ! Generic hide — catches the wall on any site/subdomain variant
    ##.sp_veil
    ##[class*="sp_message"]
    ##[id*="sp_message"]
    !
    ! Per-domain scroll-unlock (procedural :style() cannot be generic)
  ''
  + lib.concatMapStringsSep "\n" (d: "${d}##${braveScrollUnlock}") braveConsentDomains
  + "\n");
in {
  imports = [
    ../ghostty.nix
  ];

  # Set Brave as default browser after installation
  home.activation.setDefaultBrowser = lib.hm.dag.entryAfter ["writeBoundary"] ''
    run ${pkgs.duti}/bin/duti -s ${defaultBrowserBundleId} http || true
    run ${pkgs.duti}/bin/duti -s ${defaultBrowserBundleId} https || true
  '';

  # Inject Brave Shields custom filters (browser-wide) declaratively.
  # Brave stores these in Local State -> brave.ad_block.custom_filters and rewrites
  # the file at runtime, so we only apply the change when Brave is NOT running —
  # otherwise Brave overwrites it on its next flush/exit.
  #
  # This is best-effort: macOS now gates the whole BraveSoftware app-data folder
  # behind TCC, so reads/writes fail with EPERM ("Operation not permitted") unless
  # the process running the switch has Full Disk Access. A denial must SKIP with a
  # warning, never abort the switch (activation runs under `set -e`). To actually
  # apply filters, grant Full Disk Access to the terminal running switch and quit
  # Brave first.
  home.activation.braveCustomFilters = lib.hm.dag.entryAfter ["writeBoundary"] ''
    braveLocalState="$HOME/Library/Application Support/BraveSoftware/Brave-Browser/Local State"
    if [ ! -f "$braveLocalState" ]; then
      echo "brave: Local State not found (Brave never launched?); skipping custom filters"
    elif /usr/bin/pgrep -f "Brave Browser.app" > /dev/null 2>&1; then
      echo "WARNING: brave is RUNNING — custom filters were NOT applied." >&2
      echo "         Quit Brave completely, then re-run switch to apply them." >&2
    elif ! current="$(${pkgs.jq}/bin/jq -r '.brave.ad_block.custom_filters // ""' "$braveLocalState" 2>/dev/null)"; then
      echo "brave: cannot read Local State (macOS Full Disk Access / TCC); skipping custom filters" >&2
    else
      desired="$(${pkgs.jq}/bin/jq -rn --rawfile cf ${braveCustomFilters} '$cf')"
      if [ "$desired" = "$current" ]; then
        echo "brave: custom filters already up to date"
      elif tmp="$(mktemp "$(dirname "$braveLocalState")/.LocalState.XXXXXX" 2>/dev/null)" \
        && ${pkgs.jq}/bin/jq --rawfile cf ${braveCustomFilters} \
             '.brave.ad_block.custom_filters = $cf' "$braveLocalState" > "$tmp" \
        && chmod 600 "$tmp" \
        && mv "$tmp" "$braveLocalState"; then
        echo "brave: applied custom filters"
      else
        [ -n "''${tmp:-}" ] && rm -f "$tmp" 2>/dev/null || true
        echo "brave: cannot write Local State (macOS Full Disk Access / TCC); skipping custom filters" >&2
      fi
    fi
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
    run install -m 644 "${wflow}" "$workflow_dir/document.wflow"

    run /usr/bin/defaults write pbs NSServicesStatus \
      -dict-add "com.apple.Automator.Open Activity Monitor - runWorkflowAsService" \
      '{ "key_equivalent" = "^$\U001b"; }'
  '';
}
