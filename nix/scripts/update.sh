#!/bin/zsh
# Update flake inputs and validate

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
echo "Update complete. Run 'sudo ./scripts/switch.sh' to apply."
