#!/bin/zsh
# Build configuration without activating
# Catches all errors including missing packages, type mismatches, etc.

set -e

SCRIPT_DIR="${0:a:h}"
FLAKE_DIR="${SCRIPT_DIR}/.."

# Detect hostname for correct configuration
HOSTNAME=$(hostname -s)

case "$HOSTNAME" in
    NO-GLV6Y9N492|X-GLV6Y9N492|Helges-MacBook-Pro)
        # Map X-GLV6Y9N492 to NO-GLV6Y9N492 (same machine, renamed)
        CONFIG_NAME="$HOSTNAME"
        [[ "$HOSTNAME" == "X-GLV6Y9N492" ]] && CONFIG_NAME="NO-GLV6Y9N492"
        echo "Building darwin configuration for $CONFIG_NAME..."
        darwin-rebuild build --flake "$FLAKE_DIR#$CONFIG_NAME" --no-link
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
