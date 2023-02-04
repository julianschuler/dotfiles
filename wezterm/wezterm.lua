local wezterm = require("wezterm")

return {
	-- font = wezterm.font_with_fallback("Fira Code", "Sauce Code Pro Nerd Font"),
	-- font_size = 12,
	font = wezterm.font("Sauce Code Pro Nerd Font"),
	font_size = 13,
	harfbuzz_features = { "zero", "ss01", "ss03", "ss04", "ss05", "ss07", "cv04" },
	-- freetype_load_flags = "FORCE_AUTOHINT",

	enable_tab_bar = false,

	window_padding = {
		left = 2,
		right = 2,
		top = 2,
		bottom = 2,
	},

	colors = {
		background = "#282828",
		foreground = "#ebdbb2",

		ansi = {
			"#282828",
			"#cc241d",
			"#8ae234",
			"#d79921",
			"#729fcf",
			"#b16286",
			"#689d6a",
			"#a89984",
		},

		brights = {
			"#928374",
			"#fb4934",
			"#8ae234",
			"#fabd2f",
			"#729fcf",
			"#d3869b",
			"#8ec07c",
			"#ebdbb2",
		},
	},

	cursor_style = "beam",
}
