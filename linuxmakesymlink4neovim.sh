#!/bin/sh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")/nvim
echo "Creating $SCRIPTPATH symlink"
ln -s $SCRIPTPATH $HOME/.config/nvim