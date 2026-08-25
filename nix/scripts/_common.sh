#!/bin/zsh
# Shared variables for nix scripts
# Source this from other scripts: source "${0:a:h}/_common.sh"

SCRIPT_DIR="${0:a:h}"
FLAKE_DIR="${SCRIPT_DIR}/.."

# Detect hostname and map to configuration name
HOSTNAME=$(hostname -s)
CONFIG_NAME="$HOSTNAME"

# Map X-GLV6Y9N492 to NO-GLV6Y9N492 (same machine, renamed)
[[ "$CONFIG_NAME" == "X-GLV6Y9N492" ]] && CONFIG_NAME="NO-GLV6Y9N492"

# IMDI machine keeps the default WSL hostname "nixos"; map it to its config
[[ "$CONFIG_NAME" == "nixos" ]] && CONFIG_NAME="IMDI-computer"

# Determine configuration type
case "$CONFIG_NAME" in
    NO-GLV6Y9N492|Helges-MacBook-Pro)
        CONFIG_TYPE="darwin"
        ;;
    wsl-work|IMDI-computer)
        CONFIG_TYPE="nixos"
        ;;
    *)
        CONFIG_TYPE="unknown"
        ;;
esac
