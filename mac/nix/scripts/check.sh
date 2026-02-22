#!/bin/zsh
# Fast syntax check for all nix files
# Uses nil (nix LSP) for syntax validation

set -e

SCRIPT_DIR="${0:a:h}"
FLAKE_DIR="${SCRIPT_DIR}/.."

echo "Checking nix syntax..."

# Find all .nix files and check with nil
errors=0
for file in $(find "$FLAKE_DIR" -name "*.nix" -type f); do
    if ! nil diagnostics "$file" 2>/dev/null; then
        echo "Error in: $file"
        ((errors++))
    fi
done

if [[ $errors -eq 0 ]]; then
    echo "All files OK"
else
    echo "Found $errors file(s) with errors"
    exit 1
fi
