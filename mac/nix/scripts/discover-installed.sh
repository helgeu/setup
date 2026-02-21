#!/usr/bin/env bash
# Run this on a Mac to discover what's installed
# Output can be used to plan nix-darwin migration

set -e

echo "=== System Info ==="
echo "Hostname: $(hostname)"
echo "macOS: $(sw_vers -productVersion)"
echo "Arch: $(uname -m)"
echo ""

echo "=== Homebrew Formulae ==="
if command -v brew &> /dev/null; then
    brew list --formula 2>/dev/null || echo "(none)"
else
    echo "(homebrew not installed)"
fi
echo ""

echo "=== Homebrew Casks ==="
if command -v brew &> /dev/null; then
    brew list --cask 2>/dev/null || echo "(none)"
else
    echo "(homebrew not installed)"
fi
echo ""

echo "=== Mac App Store Apps ==="
if command -v mas &> /dev/null; then
    mas list 2>/dev/null || echo "(none)"
else
    echo "(mas not installed - run: brew install mas)"
fi
echo ""

echo "=== /Applications ==="
ls /Applications 2>/dev/null | grep -E '\.app$' || echo "(none)"
echo ""

echo "=== ~/Applications ==="
ls ~/Applications 2>/dev/null | grep -E '\.app$' || echo "(none)"
echo ""

echo "=== Global npm packages ==="
if command -v npm &> /dev/null; then
    npm list -g --depth=0 2>/dev/null || echo "(none)"
else
    echo "(npm not installed)"
fi
echo ""

echo "=== Python user packages ==="
if command -v pip3 &> /dev/null; then
    pip3 list --user 2>/dev/null || echo "(none)"
else
    echo "(pip3 not installed)"
fi
echo ""

echo "=== Shell ==="
echo "SHELL: $SHELL"
echo ""

echo "=== Done ==="
