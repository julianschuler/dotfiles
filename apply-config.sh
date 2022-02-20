#!/bin/bash

PWD=$(pwd)
LN="ln -sf"
CONFIG_DIR="$HOME/.config"
# get device name
DEVICE=$(hostname | sed 's/julian-//')

# create symbolic links for config files and dirs
$LN "$PWD/aerc" "$CONFIG_DIR/"
$LN "$PWD/alacritty" "$CONFIG_DIR/"
$LN "$PWD/alacritty/alacritty-$DEVICE.yml" "$PWD/alacritty/alacritty.yml"
$LN "$PWD/conky/conky-$DEVICE.conf" "$HOME/.conkyrc"
$LN "$PWD/fish" "$CONFIG_DIR/"
$LN "$PWD/ranger" "$CONFIG_DIR/"
$LN "$PWD/spectrwm.conf" "$HOME/.spectrwm.conf"
$LN "$PWD/vimrc" "$HOME/.vimrc"
$LN "$PWD/zathurarc" "$CONFIG_DIR/zathura/zathurarc"

# generate less bindings from lesskey file
lesskey lesskey

# setup fish
fish fish/install.fish
