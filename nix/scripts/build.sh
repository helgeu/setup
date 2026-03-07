#!/bin/zsh
# Build configuration without activating
# Catches all errors including missing packages, type mismatches, etc.

set -e

source "${0:a:h}/_common.sh"

case "$CONFIG_TYPE" in
    darwin)
        echo "Building darwin configuration for $CONFIG_NAME..."
        darwin-rebuild build --flake "$FLAKE_DIR#$CONFIG_NAME"
        rm -f "$FLAKE_DIR/result"
        ;;
    *)
        echo "Unknown hostname: $HOSTNAME"
        echo "Available configurations:"
        echo "  - NO-GLV6Y9N492 (work Mac)"
        echo "  - Helges-MacBook-Pro (home Mac)"
        echo "  - wsl-work (WSL)"
        exit 1
        ;;
esac

echo "Build successful!"
