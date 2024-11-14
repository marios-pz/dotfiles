-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()
config.default_prog = { "/usr/bin/fish", "-l" }
config.color_scheme = "Batman"
config.font_size = 14
-- config.window_decorations = "RESIZE"
-- config.enable_tab_bar = true
-- enable when nerd flex
-- config.window_background_image = "full path"
-- config.window_background_opacity = 0.1
config.font = wezterm.font("JetBrains Mono")
return config
