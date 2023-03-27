# Start Hyprland at login
status is-login && [ -z "$DISPLAY" -a "$XDG_VTNR" = 1 ]  && exec Hyprland &> /dev/null

set -l script_dir (realpath (dirname (status -f)))
source "$script_dir/abbreviations.fish"
