local wezterm = require("wezterm")

local fonts = { "VictorMono Nerd Font", "Fira Code", "JetBrains Mono", "Cascadia Code", "Hack Nerd Font" }
local font_size = 14.0
local theme = {
  background = "#161616",
  foreground = "#f4f4f4",
  brights = {
    "#f4f4f4",
    "#ff9e64",
    "#6ACBCB",
    "#CE27BD",
    "#06a4c7",
    "#9F5D62",
    "#B5A075",
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
local function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return ' ' .. title .. ' '
  end
  -- Otherwise, use the title from the active pane
  return ' ' .. tab_info.active_pane.title .. ' '
end

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local title = tab_title(tab)
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

return {
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
        File = '/Users/vincent/.config/kitty/bg/mountains.png',
      },
    },
  },
  front_end = "WebGpu",
  webgpu_power_preference = "HighPerformance",
  enable_wayland = false,
  window_decorations = "RESIZE",
  -- window_decorations = "INTEGRATED_BUTTONS|RESIZE",
  font = wezterm.font_with_fallback(fonts),
  font_size = font_size,
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = false,
  tab_bar_at_bottom = true,
  colors = {
    background = theme.background,
    tab_bar = {
      background = theme.panel.background,
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
  window_frame = {
    font = wezterm.font_with_fallback(fonts),
    font_size = font_size,
  },
  window_padding = {
    left = 8, right = 3,
    top = 3, bottom = 0,
  },
}
