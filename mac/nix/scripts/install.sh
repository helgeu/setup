#!/usr/bin/env bash
# Bootstrap script for nix-darwin
# Detects hostname and installs appropriate configuration

set -e

HOSTNAME=$(hostname -s)

echo "=== Nix Installation ==="
echo ""
echo "Detected hostname: $HOSTNAME"
echo ""

# Check if hostname matches a known configuration
case "$HOSTNAME" in
    NO-GLV6Y9N492|Helges-MacBook-Pro)
        echo "Configuration found for $HOSTNAME"
        ;;
    *)
        echo "Unknown hostname: $HOSTNAME"
        echo "Available configurations:"
        echo "  - NO-GLV6Y9N492 (Work Mac)"
        echo "  - Helges-MacBook-Pro (Personal Mac)"
        exit 1
        ;;
esac

read -p "Install configuration for $HOSTNAME? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 1
fi

# Check if Nix is already installed
if command -v nix &> /dev/null; then
    echo ""
    echo "Nix is already installed."
else
    echo ""
    echo "=== Installing Nix (official installer) ==="
    sh <(curl -L https://nixos.org/nix/install) --daemon

    echo ""
    echo "Sourcing Nix profile..."
    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    elif [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
        . "$HOME/.nix-profile/etc/profile.d/nix.sh"
    fi

    echo ""
    echo "=== Enabling flakes ==="
    sudo mkdir -p /etc/nix
    echo "experimental-features = nix-command flakes" | sudo tee -a /etc/nix/nix.conf
fi

echo ""
echo "=== Bootstrapping nix-darwin for $HOSTNAME ==="
cd "$(dirname "$0")/.."

nix run nix-darwin -- switch --flake ".#$HOSTNAME"

echo ""
echo "=== Done ==="
echo ""
echo "Next steps:"
echo "1. Restart your terminal"
echo "2. Grant App Management permission to Terminal in System Settings"
echo "3. Future rebuilds: sudo ./switch.sh"
