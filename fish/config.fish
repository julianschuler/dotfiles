# Start niri at login
status is-login && [ -z "$DISPLAY" -a "$XDG_VTNR" = 1 ] && exec ssh-agent niri-session

set -l script_dir (realpath (dirname (status -f)))
source "$script_dir/abbreviations.fish"
