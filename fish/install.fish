# Initial setup for fish.
# colors
set -U fish_color_autosuggestion 9C9C9C
set -U fish_color_cancel \x2dr
set -U fish_color_command F4F4F4
set -U fish_color_comment B0B0B0
set -U fish_color_cwd green
set -U fish_color_cwd_root red
set -U fish_color_end 969696
set -U fish_color_error FFA779
set -U fish_color_escape 00a6b2
set -U fish_color_history_current \x2d\x2dbold
set -U fish_color_host normal
set -U fish_color_host_remote yellow
set -U fish_color_match \x2d\x2dbackground\x3dbrblue
set -U fish_color_normal normal
set -U fish_color_operator 00a6b2
set -U fish_color_param A0A0F0
set -U fish_color_quote 666A80
set -U fish_color_redirection FAFAFA
set -U fish_color_search_match bryellow\x1e\x2d\x2dbackground\x3dbrblack
set -U fish_color_selection white\x1e\x2d\x2dbold\x1e\x2d\x2dbackground\x3dbrblack
set -U fish_color_status red
set -U fish_color_user brgreen
set -U fish_color_valid_path \x2d\x2dunderline
set -U fish_pager_color_completion normal
set -U fish_pager_color_description B3A06D\x1eyellow
set -U fish_pager_color_prefix white\x1e\x2d\x2dbold\x1e\x2d\x2dunderline
set -U fish_pager_color_progress brwhite\x1e\x2d\x2dbackground\x3dcyan

# disable greeting
set -U fish_greeting

# generate zoxide config
zoxide init fish > "$HOME/.config/fish/conf.d/zoxide.fish"

# install plugins listed in fish_plugins
curl -sL https://git.io/fisher | source && fisher update
