# Start niri at login
status is-login && [ -z "$DISPLAY" -a "$XDG_VTNR" = 1 ] && exec ssh-agent niri-session

set -l script_dir (realpath (dirname (status -f)))
source "$script_dir/abbreviations.fish"

fzf --fish | source
starship init fish | source

# Execute a command with the arguments selected by fzf
function fzf-execute
    fzf $FZF_DEFAULT_OPTS --preview $FZF_PREVIEW_CMD --print0 | xargs -r -0 $argv[1..]
    commandline -f repaint
end

# Edit file
bind \ce "fzf-execute $EDITOR"
# Copy absolute file path
bind \co "fzf-execute realpath | wl-copy"
