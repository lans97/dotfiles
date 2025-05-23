local wezterm = require 'wezterm'

local config = wezterm.config_builder()
config.enable_wayland = false

config.color_scheme = 'rose-pine'
config.window_background_opacity = 0.7
config.font = wezterm.font 'CodeNewRoman Nerd Font'

return config
