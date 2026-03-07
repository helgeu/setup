#!/bin/zsh
# Evaluate all configurations without building
# Catches missing packages, type errors, invalid options - faster than full build

set -e

source "${0:a:h}/_common.sh"

failed=0

eval_config() {
    local type=$1 name=$2
    echo "Evaluating $type configuration for $name..."
    if nix eval "$FLAKE_DIR#${type}Configurations.$name.config.system.build.toplevel" > /dev/null; then
        echo "  OK"
    else
        echo "  FAILED"
        ((failed++))
    fi
}

eval_config darwin NO-GLV6Y9N492
eval_config darwin Helges-MacBook-Pro
eval_config nixos wsl-work

if [[ $failed -eq 0 ]]; then
    echo "All evaluations successful!"
else
    echo "$failed configuration(s) failed evaluation"
    exit 1
fi
