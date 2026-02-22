#!/bin/zsh
# Evaluate configuration without building
# Catches missing packages, type errors, invalid options - faster than full build

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
        echo "Evaluating darwin configuration for $CONFIG_NAME..."
        nix eval "$FLAKE_DIR#darwinConfigurations.$CONFIG_NAME.config.system.build.toplevel" > /dev/null
        ;;
    *)
        echo "Unknown hostname: $HOSTNAME"
        echo "Evaluating all configurations..."
        nix eval "$FLAKE_DIR#darwinConfigurations.NO-GLV6Y9N492.config.system.build.toplevel" > /dev/null
        ;;
esac

echo "Evaluation successful!"
