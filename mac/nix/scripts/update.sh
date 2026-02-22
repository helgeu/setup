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
echo "Update complete. Run 'sudo ./scripts/switch.sh' to apply."
