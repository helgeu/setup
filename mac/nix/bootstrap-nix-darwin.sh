#!/bin/zsh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

nix run nix-darwin/master#darwin-rebuild \
  --extra-experimental-features 'nix-command flakes' \
  -- switch --flake "$SCRIPT_DIR"
