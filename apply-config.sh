#!/bin/sh

ln_cmd="ln -sf"
config_dir="$HOME/.config"
dot_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
device=$(hostnamectl hostname | cut -d- -f2)

# flags to be set
create_links=false
install_packages=false
setup_fish=false


usage() {
    >&2 echo \
"Usage: $(basename $0) [OPTIONS]
Available flags (at least one required):
  -a  Apply all configuration, equivalent to -lpf
  -l  Create symlinks for config files and directories
  -p  Install packages listed in packages.txt using paru
  -f  Setup fish and install fish plugins
  -h  Show this help message"
}

if [[ $# -eq 0 ]]; then
    usage
    exit 1;
fi

# set flags according to input parameters
while getopts "alfph" arg; do
    case $arg in
        "a")
            create_links=false
            install_packages=false
            setup_fish=false
            ;;
        "f")
            setup_fish=true
            ;;
        "l")
            create_links=true
            ;;
        "p")
            install_packages=true
            ;;
        "h")
            usage
            exit 0;
            ;;
        "?")
            usage
            exit 1;
            ;;
    esac
done

# create symbolic links for config files and directories
if [ "$CREATE_LINKS" = true ]; then
    $ln_cmd "$dot_dir/aerc" "$config_dir/"
    $ln_cmd "$dot_dir/alacritty" "$config_dir/"
    $ln_cmd "$dot_dir/alacritty/alacritty-$device.yml" "$dot_dir/alacritty/alacritty.yml"
    $ln_cmd "$dot_dir/conky/conky-$device.conf" "$HOME/.conkyrc"
    $ln_cmd "$dot_dir/fish" "$config_dir/"
    $ln_cmd "$dot_dir/lesskey" "$HOME/.lesskey"
    $ln_cmd "$dot_dir/ranger" "$config_dir/"
    $ln_cmd "$dot_dir/starship.toml" "$config_dir/"
    $ln_cmd "$dot_dir/spectrwm.conf" "$HOME/.spectrwm.conf"
    $ln_cmd "$dot_dir/vimrc" "$HOME/.vimrc"
    $ln_cmd "$dot_dir/xinitrc" "$HOME/.xinitrc"
    $ln_cmd "$dot_dir/zathura" "$config_dir/"
fi

# install packages using paru
if [ "$install_packages" = true ]; then
    cut "-d " -f1 "$dot_dir/packages.txt" | xargs paru -S
fi

# setup fish and install fish plugins
if [ "$setup_fish" = true ]; then
    fish "$dot_dir/fish/install.fish"
fi
