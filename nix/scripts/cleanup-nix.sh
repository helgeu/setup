#!/bin/zsh
# Delete old nix generations and garbage-collect the store.
#
# Usage:
#   ./scripts/cleanup-nix.sh            # delete generations older than 14d, then GC
#   ./scripts/cleanup-nix.sh 7d         # custom age (e.g. 7d, 30d)
#   ./scripts/cleanup-nix.sh --all      # delete ALL old generations (keep current only)
#   ./scripts/cleanup-nix.sh --dry-run  # show what would be freed, change nothing

set -e

source "${0:a:h}/_common.sh"

AGE="14d"
DRY_RUN=false
ALL=false

for arg in "$@"; do
    case "$arg" in
        --dry-run) DRY_RUN=true ;;
        --all)     ALL=true ;;
        *d|*w|*m)  AGE="$arg" ;;
        *)
            echo "Unknown argument: $arg"
            echo "Usage: cleanup-nix.sh [<age>|--all] [--dry-run]"
            exit 1
            ;;
    esac
done

echo "=== Nix Cleanup ==="
if $ALL; then
    echo "Mode: delete ALL old generations (keep current only)"
    GC_ARGS=(--delete-old)
else
    echo "Mode: delete generations older than $AGE"
    GC_ARGS=(--delete-older-than "$AGE")
fi
$DRY_RUN && echo "(dry run — nothing will be deleted)"
echo ""

echo "--- Before ---"
echo "Store size: $(du -sh /nix/store 2>/dev/null | cut -f1)"
echo ""

if $DRY_RUN; then
    echo "--- Would delete (dry run) ---"
    nix-collect-garbage "${GC_ARGS[@]}" --dry-run
    sudo nix-collect-garbage "${GC_ARGS[@]}" --dry-run
    echo ""
    echo "Dry run complete. No changes made."
    exit 0
fi

echo "--- Deleting user profile generations + GC ---"
nix-collect-garbage "${GC_ARGS[@]}"

echo ""
echo "--- Deleting system/root profile generations + GC (sudo) ---"
sudo nix-collect-garbage "${GC_ARGS[@]}"

echo ""
echo "--- Optimising store (deduplicate) ---"
nix store optimise

echo ""
echo "--- After ---"
echo "Store size: $(du -sh /nix/store 2>/dev/null | cut -f1)"
echo ""
echo "Cleanup complete."
echo "Remaining system generations:"
case "$CONFIG_TYPE" in
    darwin) sudo darwin-rebuild --list-generations 2>/dev/null || nix-env -p /nix/var/nix/profiles/system --list-generations ;;
    nixos)  sudo nix-env -p /nix/var/nix/profiles/system --list-generations ;;
esac
