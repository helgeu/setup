#!/bin/zsh
# Build and activate configuration (requires sudo on macOS)

set -e

source "${0:a:h}/_common.sh"

case "$CONFIG_TYPE" in
    darwin)
        echo "Switching to darwin configuration for $CONFIG_NAME..."
        darwin-rebuild switch --flake "$FLAKE_DIR#$CONFIG_NAME"
        ;;
    nixos)
        echo "Switching to nixos configuration for $CONFIG_NAME..."
        nixos-rebuild switch --flake "$FLAKE_DIR#$CONFIG_NAME"
        ;;
    *)
        echo "Unknown hostname: $HOSTNAME"
        exit 1
        ;;
esac

echo "Switch successful!"
