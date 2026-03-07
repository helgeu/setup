#!/usr/bin/env bash
# Post-installation setup script for NixOS-WSL
# Run this inside WSL after the PowerShell bootstrap completes

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FLAKE_DIR="$(dirname "$SCRIPT_DIR")"

echo ""
echo "=== NixOS-WSL Setup ==="
echo ""

# Check if running in WSL
if [ ! -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
    echo "Error: This script must be run inside WSL"
    exit 1
fi

# Check if flake exists
if [ ! -f "$FLAKE_DIR/flake.nix" ]; then
    echo "Error: flake.nix not found at $FLAKE_DIR"
    echo "Make sure you've cloned the repository correctly."
    exit 1
fi

# Determine hostname
HOSTNAME="${1:-wsl-work}"

echo "Flake directory: $FLAKE_DIR"
echo "Target configuration: $HOSTNAME"
echo ""

# Check if configuration exists
if ! grep -q "\"$HOSTNAME\"" "$FLAKE_DIR/flake.nix"; then
    echo "Warning: Configuration '$HOSTNAME' not found in flake.nix"
    echo "Available configurations:"
    grep -E "nixosConfigurations\." "$FLAKE_DIR/flake.nix" | head -5 || echo "  (none yet - need to add nixosConfigurations)"
    echo ""
    read -p "Continue anyway? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Run nixos-rebuild
echo ""
echo "=== Running nixos-rebuild ==="
echo ""

sudo nixos-rebuild switch --flake "$FLAKE_DIR#$HOSTNAME"

echo ""
echo "=== Setup Complete ==="
echo ""
echo "Your NixOS-WSL system has been configured!"
echo ""
echo "Useful commands:"
echo "  nixos-rebuild switch --flake $FLAKE_DIR#$HOSTNAME  # Rebuild"
echo "  home-manager switch --flake $FLAKE_DIR#$HOSTNAME   # Home only"
echo ""
