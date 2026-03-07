#!/bin/zsh
# Health check for nix configuration staleness
set -e

SCRIPT_DIR="${0:a:h}"
FLAKE_DIR="${SCRIPT_DIR}/.."

echo "=== Nix Configuration Health Check ==="
echo ""

# 1. Check for fork inputs
echo "--- Fork Inputs ---"
KNOWN_ORGS="NixOS|LnL7|nix-community|zhaofengli|homebrew|notashelf|DeterminateSystems"
FORKS=$(grep -E 'url = "github:' "$FLAKE_DIR/flake.nix" | grep -vE "($KNOWN_ORGS)" | grep -v "^[[:space:]]*#" || true)
if [[ -n "$FORKS" ]]; then
    echo "⚠ Non-upstream inputs found:"
    echo "$FORKS"
    echo "Check if upstream PRs have been merged."
else
    echo "✓ All inputs are from upstream sources."
fi

echo ""

# 2. Check for overlay TODOs/workarounds
echo "--- Overlay Status ---"
OVERLAYS=$(find "$FLAKE_DIR/overlays" -name "*.nix" -type f 2>/dev/null || true)
if [[ -n "$OVERLAYS" ]]; then
    for f in $OVERLAYS; do
        if grep -qi "TEMPORARY\|WORKAROUND\|TODO\|FIXME" "$f"; then
            echo "⚠ $(basename $f): Contains temporary workaround"
            grep -i "TEMPORARY\|WORKAROUND\|TODO\|FIXME" "$f" | head -3
        fi
    done
else
    echo "✓ No overlay files found."
fi

echo ""

# 3. Check for commented-out code
echo "--- Commented-Out Code ---"
COMMENTED=$(grep -rn "^[[:space:]]*#[^!]" "$FLAKE_DIR"/*.nix "$FLAKE_DIR"/**/*.nix 2>/dev/null | grep -v "# " | grep -v "flake.lock" | head -10 || true)
if [[ -n "$COMMENTED" ]]; then
    echo "⚠ Potentially commented-out code found (review manually):"
    echo "$COMMENTED"
else
    echo "✓ No suspicious commented-out code."
fi

echo ""

# 4. Check flake input ages
echo "--- Flake Input Ages ---"
echo "Run 'nix flake metadata' to check input ages manually."
echo "(Automated age checking requires parsing lock file dates)"
