#!/usr/bin/env bash
# Run this on a Mac before switching to Nix management
# Removes all Homebrew packages so Nix can take over

set -e

echo "=== Homebrew Cleanup Script ==="
echo "This will remove all Homebrew casks and formulae."
echo ""

read -p "Continue? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 1
fi

echo ""
echo "=== Uninstalling Homebrew Casks ==="
brew list --cask | xargs -I {} brew uninstall --cask {} 2>/dev/null || echo "(none)"

echo ""
echo "=== Uninstalling Homebrew Formulae ==="
brew list --formula | xargs -I {} brew uninstall --ignore-dependencies {} 2>/dev/null || echo "(none)"

echo ""
echo "=== Done ==="
echo "Homebrew packages removed. You can now run Nix switch."
echo ""
echo "Optional: To remove Homebrew entirely, run:"
echo '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"'
