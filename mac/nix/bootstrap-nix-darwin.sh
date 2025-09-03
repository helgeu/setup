#!/bin/zsh

sudo nix run nix-darwin --extra-experimental-features nix-command --extra-experimental-features flakes -- switch --flake ~/git/github/setup/mac/nix

