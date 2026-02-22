#!/bin/zsh
# Evaluate configuration without building
# Catches missing packages, type errors, invalid options - faster than full build

set -e

SCRIPT_DIR="${0:a:h}"
FLAKE_DIR="${SCRIPT_DIR}/.."

# Detect hostname for correct configuration
HOSTNAME=$(hostname -s)

case "$HOSTNAME" in
    NO-GLV6Y9N492|Helges-MacBook-Pro)
        echo "Evaluating darwin configuration for $HOSTNAME..."
        nix eval "$FLAKE_DIR#darwinConfigurations.$HOSTNAME.config.system.build.toplevel" --no-build > /dev/null
        ;;
    *)
        echo "Unknown hostname: $HOSTNAME"
        echo "Evaluating all configurations..."
        nix eval "$FLAKE_DIR#darwinConfigurations.NO-GLV6Y9N492.config.system.build.toplevel" --no-build > /dev/null
        ;;
esac

echo "Evaluation successful!"
