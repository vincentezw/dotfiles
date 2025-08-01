local wezterm = require("wezterm")
local is_linux <const> = wezterm.target_triple:find("linux") ~= nil

-- local victor_font = is_linux and "Victor Mono Nerd Font" or "VictorMono NFM"
local victor_font = is_linux and "Victor Mono Nerd Font" or "VictorMono Nerd Font Mono"
local fonts = { victor_font, "Fira Code", "JetBrains Mono", "Cascadia Code", "Hack Nerd Font" }
local font_size = wezterm.hostname() == "ashi" and 11.0 or 14.0
local theme = {
  background = "#161616",
  foreground = "#f4f4f4",
  colours = {
    white = "#f4f4f4",
    orange = "#ff9e64",
    teal = "#6ACBCB",
    pink = "#CE27BD",
    cyan = "#06a4c7",
    brown = "#9F5D62",
    yellow = "#B5A075",
  },
  panel = {
    background = "#161616",
  },
  tab_active = {
    background = "#3f66a6",
    foreground = "#ff9e64",
  },
  tab_inactive = {
    background = "#1a1a1a",
    foreground = "#9e9e9e",
  },
}

local tab_edge_right = ""
local tab_edge_left = ""
local function tab_title(tab_info, pane)
  local tmux_session = pane.user_vars.tab_title
  if tmux_session and #tmux_session > 0 then
    return ' ' .. tmux_session .. ' '
  end
  local title = tab_info.tab_title
  if title and #title > 0 then
    return ' ' .. title .. ' '
  end
  return ' ' .. tab_info.active_pane.title .. ' '
end

local window_decorations = is_linux and "NONE" or "RESIZE"

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local pane = tab.active_pane
    local title = tab_title(tab, pane)
    if tab.is_active then
      return {
        { Background = { Color = theme.panel.background } },
        { Foreground = { Color = theme.tab_active.background } },
        { Text = tab_edge_left },
        { Background = { Color = theme.tab_active.background } },
        { Foreground = { Color = theme.foreground } },
        { Attribute={Italic=true}},
        { Text = title .. ' ' },
        { Background = { Color = theme.panel.background } },
        { Foreground = { Color = theme.tab_active.background } },
        { Text = tab_edge_right },
      }
    else
      return {
        { Background = { Color = theme.panel.background } },
        { Foreground = { Color = theme.tab_inactive.foreground } },
        { Text = ' ' .. tab.tab_index+1 .. ': ' .. title .. ' ' },
      }
    end
  end
)
local dimmer = { brightness = 0.5 }

local config = {
  background = {
    {
      height = '100%',
      opacity = 1.0,
      source = {
        Color = '#161616',
      },
      width = '100%',
    },
    {
      hsb = dimmer,
      opacity = 0.1,
      repeat_x = 'Mirror',
      repeat_y = 'Mirror',
      source = {
        File = wezterm.home_dir .. '/.config/kitty/bg/mountains.png',
      },
    },
  },
  ssh_domains = {
    {
      name = 'xena',
      remote_address = '192.168.0.10',
      username = 'vincent',
    },
  },
  front_end = "WebGpu",
  webgpu_power_preference = "HighPerformance",
  enable_wayland = true,
  window_decorations = window_decorations,
  -- window_decorations = "INTEGRATED_BUTTONS|RESIZE",
  font = wezterm.font_with_fallback(fonts),
  font_size = font_size,
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = true,
  inactive_pane_hsb = {
    saturation = 0.8,
    brightness = 0.5,
  },
  colors = {
    background = theme.background,
    tab_bar = {
      background = theme.panel.background,
    },
    split = theme.colours.cyan,
  },
  keys = {
    {
      key = "%",
      mods = "CTRL|SHIFT",
      action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
    },
    {
      key = "\"",
      mods = "CTRL|SHIFT",
      action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
    },
  },
  max_fps = 120,
  tab_bar_style = {
    new_tab = wezterm.format {
      { Foreground = { Color = theme.foreground } },
      { Background = { Color = theme.panel.background } },
      { Text = " 󰐕 " },
    },
    new_tab_hover = wezterm.format {
      { Foreground = { Color = "#CE27BD" } },
      { Background = { Color = theme.panel.background } },
      { Text = " 󰐕 " },
    },
  },
  tab_max_width = 128,
  window_frame = {
    font = wezterm.font_with_fallback(fonts),
    font_size = font_size,
  },
  window_padding = {
    left = 8, right = 3,
    top = 13, bottom = 0,
  },
}

local smart_splits = wezterm.plugin.require('https://github.com/mrjones2014/smart-splits.nvim')
-- you can put the rest of your Wezterm config here
smart_splits.apply_to_config(config, {
  -- the default config is here, if you'd like to use the default keys,
  -- you can omit this configuration table parameter and just use
  -- smart_splits.apply_to_config(config)

  -- directional keys to use in order of: left, down, up, right
  direction_keys = { 'h', 'j', 'k', 'l' },
  -- if you want to use separate direction keys for move vs. resize, you
  -- can also do this:
  -- modifier keys to combine with direction_keys
  modifiers = {
    move = 'CTRL', -- modifier to use for pane movement, e.g. CTRL+h to move left
    resize = 'META', -- modifier to use for pane resize, e.g. META+h to resize to the left
  },
  -- log level to use: info, warn, error
  log_level = 'info',
})

return config
