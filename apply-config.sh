#!/bin/bash

PWD=$(pwd)
LN="ln -sf"
CONFIG_DIR="$HOME/.config"
# get device name
DEVICE=$(hostname | sed 's/julian-//')

# create symbolic links for config files and dirs
$LN "$PWD/alacritty.yml" "$HOME/.alacritty.yml"
$LN "$PWD/alacritty-config-$DEVICE.yml" "$HOME/.alacritty-config.yml"
$LN "$PWD/conkyrc-$DEVICE" "$HOME/.conkyrc"
$LN "$PWD/fish" "$CONFIG_DIR/"
$LN "$PWD/ranger" "$CONFIG_DIR/"
$LN "$PWD/spectrwm.conf" "$HOME/.spectrwm.conf"
$LN "$PWD/vimrc" "$HOME/.vimrc"
$LN "$PWD/zathurarc" "$CONFIG_DIR/zathura/zathurarc"

# generate less bindings from lesskey file
lesskey lesskey

# setup fish
fish fish/install.fish
