#!/bin/bash
# Uninstall Nix completely from macOS
# Run this if you need to start fresh

set -e

echo "=== Nix Uninstaller ==="
echo ""
echo "This will completely remove Nix from your system:"
echo "  - Restore shell configs"
echo "  - Remove nix-daemon"
echo "  - Delete nixbld users/group"
echo "  - Delete /nix volume"
echo ""

read -p "Are you sure? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 1
fi

echo ""
echo "=== Step 1: Restore shell configs ==="

sudo mv /etc/zshrc.backup-before-nix /etc/zshrc 2>/dev/null || echo "  /etc/zshrc.backup-before-nix not found"
sudo mv /etc/bashrc.backup-before-nix /etc/bashrc 2>/dev/null || echo "  /etc/bashrc.backup-before-nix not found"
sudo mv /etc/bash.bashrc.backup-before-nix /etc/bash.bashrc 2>/dev/null || echo "  /etc/bash.bashrc.backup-before-nix not found"

echo ""
echo "=== Step 2: Unload and remove daemons ==="

sudo launchctl unload /Library/LaunchDaemons/org.nixos.nix-daemon.plist 2>/dev/null || true
sudo rm -f /Library/LaunchDaemons/org.nixos.nix-daemon.plist
sudo launchctl unload /Library/LaunchDaemons/org.nixos.darwin-store.plist 2>/dev/null || true
sudo rm -f /Library/LaunchDaemons/org.nixos.darwin-store.plist

echo ""
echo "=== Step 3: Remove nixbld users and group ==="

sudo dscl . -delete /Groups/nixbld 2>/dev/null || true
for u in $(sudo dscl . -list /Users 2>/dev/null | grep _nixbld); do
    sudo dscl . -delete /Users/$u 2>/dev/null || true
done

echo ""
echo "=== Step 4: Remove Nix files and profiles ==="

sudo rm -rf /etc/nix
sudo rm -rf /var/root/.nix-profile /var/root/.nix-defexpr /var/root/.nix-channels
rm -rf ~/.nix-profile ~/.nix-defexpr ~/.nix-channels

echo ""
echo "=== Step 5: Delete /nix APFS volume ==="

sudo diskutil apfs deleteVolume /nix 2>/dev/null || echo "  /nix volume not found or already deleted"

echo ""
echo "=== Nix has been uninstalled ==="
echo ""
echo "You may need to restart your terminal or reboot."
