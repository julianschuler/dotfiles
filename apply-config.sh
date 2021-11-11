#!/bin/bash

PWD=$(pwd)
LN="ln -sf"
CONFIG_DIR="$HOME/.config"
# get conky version to use from system hostname
CONKY_VERSION=$(hostname | sed 's/julian-//')

# create symbolic links for config files and dirs
$LN "$PWD/vimrc" "$HOME/.vimrc"
$LN "$PWD/alacritty.yml" "$HOME/.alacritty.yml"
$LN "$PWD/spectrwm.conf" "$HOME/.spectrwm.conf"
$LN "$PWD/conkyrc-$CONKY_VERSION" "$HOME/.conkyrc"
$LN "$PWD/ranger" "$CONFIG_DIR/"
$LN "$PWD/zathurarc" "$CONFIG_DIR/zathura/zathurarc"

# generate less bindings from lesskey file
lesskey lesskey
