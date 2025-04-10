local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'Catppuccin Mocha'

config.font = wezterm.font 'JetBrains Mono'
config.font_size = 13.0

config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'
config.window_padding = {
  top = '1.5cell'
}

return config
