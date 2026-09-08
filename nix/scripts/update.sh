#!/bin/zsh
# Find upgrades and prep for the switch. This does NOT upgrade software.
# It updates the flake lock (nix) and refreshes Homebrew tap metadata, then
# previews what is outdated. The actual upgrades (nix + Homebrew + Mac App
# Store) are applied by `switch.sh` via nix-darwin activation
# (homebrew.onActivation.upgrade = true). See system/shared.nix + readme.

set -e

SCRIPT_DIR="${0:a:h}"
cd "$SCRIPT_DIR/.."

echo "Current input ages:"
nix flake metadata 2>/dev/null | grep -E "^\s+└|^\s+├" | head -10

echo ""
echo "Updating flake inputs..."
nix flake update --commit-lock-file

echo ""
echo "Validating configuration..."
./scripts/eval.sh

echo ""
echo "Checking for non-upstream inputs..."
# Known upstream orgs - inputs from other sources are flagged as forks
KNOWN_ORGS="NixOS|LnL7|nix-community|zhaofengli|homebrew|notashelf|DeterminateSystems"
if grep -E 'url = "github:' "$SCRIPT_DIR/../flake.nix" | grep -vE "($KNOWN_ORGS)" | grep -v "^[[:space:]]*#"; then
    echo "⚠ Fork inputs detected above. Check if upstream PRs have been merged."
else
    echo "No fork inputs detected."
fi

echo ""
echo "Refreshing Homebrew tap metadata (finding upgrades)..."
if command -v brew &>/dev/null; then
    # nix-homebrew points HOMEBREW_REPOSITORY at a stub with a fake .git, so
    # `brew update` can intermittently die with "fatal: not in a git directory"
    # on a cold API cache. It clears on retry and only refreshes metadata, so
    # keep it best-effort: the flake lock is already committed above and the
    # switch applies brew upgrades regardless (onActivation.upgrade = true).
    if ! (brew update || { sleep 2; brew update; }); then
        echo "⚠ brew update failed (nix-homebrew git stub / transient) - continuing."
    fi
    echo "Homebrew packages the switch will upgrade:"
    brew outdated --greedy || echo "⚠ brew outdated failed - continuing."
else
    echo "Homebrew not installed - skipping (non-macOS)."
fi

echo ""
echo "Mac App Store apps the switch will upgrade:"
if command -v mas &>/dev/null; then
    mas outdated || echo "⚠ mas outdated failed - continuing."
else
    echo "mas not installed - skipping (non-macOS)."
fi

echo ""
echo "Prep complete. Nothing upgraded yet."
echo "Run 'sudo ./scripts/switch.sh' to apply nix + Homebrew + App Store upgrades."
