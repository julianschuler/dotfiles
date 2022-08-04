#!/bin/sh

# exit on errors
set -e

# print usage information and exit
print_usage() {
    >&2 echo \
"Usage: $(basename $0) [OPTIONS]
Apply (parts of) the configuration to the system.

Available options (at least one required):
  -a    Apply all of the configuration, equivalent to -lpf
  -l    Create symlinks for configuration files and directories
  -p    Install packages listed in packages.txt using paru
  -f    Setup fish and install fish plugins
  -h    Show this help message"
    exit 0
}

# output message to stderr
print_debug() {
    >&2 echo "$1"
}

# print error message and exit
print_error() {
	if [ "$#" -gt 0 ]; then
		>&2 echo "$1"
	fi
	>&2 echo "Use \"$(basename $0) -h\" for further information."
	exit 1
}

# flags to be set
create_links=false
install_packages=false
setup_fish=false

# set flags according to input parameters
while getopts "alfph" arg; do
    case $arg in
        "a") create_links=true; install_packages=true; setup_fish=true ;;
        "f") setup_fish=true ;;
        "l") create_links=true ;;
        "p") install_packages=true ;;
        "h") print_usage; exit 0 ;;
        "?") print_error; exit 1 ;;
    esac
done

# test if at least one flag was specified
if [ "$OPTIND" -eq 1 ]; then
    print_error "No options specified."
fi
shift $(( OPTIND - 1 ))

# commands and directories
ln_cmd="ln -sf"
config_dir="$HOME/.config"
dot_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
device=$(hostnamectl hostname | cut -d- -f2)

# create symbolic links for config files and directories
if [ "$create_links" = true ]; then
    print_debug "Creating symlinks for the configuration files and directories..."
    $ln_cmd "$dot_dir/aerc" "$config_dir/"
    $ln_cmd "$dot_dir/alacritty" "$config_dir/"
    $ln_cmd "$dot_dir/alacritty/alacritty-$device.yml" "$dot_dir/alacritty/alacritty.yml"
    $ln_cmd "$dot_dir/conky/conky-$device.conf" "$HOME/.conkyrc"
    $ln_cmd "$dot_dir/fish" "$config_dir/"
    $ln_cmd "$dot_dir/lesskey" "$HOME/.lesskey"
    $ln_cmd "$dot_dir/ranger" "$config_dir/"
    $ln_cmd "$dot_dir/rofi" "$config_dir/"
    $ln_cmd "$dot_dir/starship.toml" "$config_dir/"
    $ln_cmd "$dot_dir/spectrwm.conf" "$HOME/.spectrwm.conf"
    $ln_cmd "$dot_dir/vimrc" "$HOME/.vimrc"
    $ln_cmd "$dot_dir/xinitrc" "$HOME/.xinitrc"
    $ln_cmd "$dot_dir/zathura" "$config_dir/"
    print_debug ""
fi

# install packages using paru
if [ "$install_packages" = true ]; then
    print_debug "Installing packages from package.txt using paru..."
    cut "-d " -f1 "$dot_dir/packages.txt" | xargs paru -S
    print_debug ""
fi

# setup fish and install fish plugins
if [ "$setup_fish" = true ]; then
    print_debug "Setting up fish..."
    fish "$dot_dir/fish/install.fish"
    print_debug ""
fi

print_debug "Configuration applied sucessfully."
