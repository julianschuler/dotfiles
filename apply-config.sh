#!/bin/sh

PWD=$(pwd)
LN="ln -sf"
CONFIG_DIR="$HOME/.config"
# get device name
DEVICE=$(hostnamectl hostname | sed 's/julian-//')

# create symbolic links for config files and dirs
$LN "$PWD/aerc" "$CONFIG_DIR/"
$LN "$PWD/alacritty" "$CONFIG_DIR/"
$LN "$PWD/alacritty/alacritty-$DEVICE.yml" "$PWD/alacritty/alacritty.yml"
$LN "$PWD/conky/conky-$DEVICE.conf" "$HOME/.conkyrc"
$LN "$PWD/fish" "$CONFIG_DIR/"
$LN "$PWD/lesskey" "$HOME/.lesskey"
$LN "$PWD/ranger" "$CONFIG_DIR/"
$LN "$PWD/starship.toml" "$CONFIG_DIR/"
$LN "$PWD/spectrwm.conf" "$HOME/.spectrwm.conf"
$LN "$PWD/vimrc" "$HOME/.vimrc"
$LN "$PWD/xinitrc" "$HOME/.xinitrc"
$LN "$PWD/zathura" "$CONFIG_DIR/"

# setup fish
fish fish/install.fish
