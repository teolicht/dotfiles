-- Pull in the wezterm API
local wezterm = require('wezterm')

local act = wezterm.action

-- Holds the configuration
local config = wezterm.config_builder()

config.max_fps = 165

-- (Testing domains)
config.unix_domains = {
  {
    name = 'unix',
  },
}

------- SHORTCUTS -------
config.leader = {
  key = 'a',
  mods = 'CTRL|ALT',
  timout_milliseconds = 1000,
}
config.keys = {
  -- Splitting panes
  {
    mods = 'LEADER',
    key = '%',
    action = act.SplitVertical({ domain = 'CurrentPaneDomain' }),
  },
  {
    mods = 'LEADER',
    key = '"',
    action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
  },
  -- Maximize panes
  {
    mods = 'LEADER',
    key = 'm',
    action = act.TogglePaneZoomState,
  },
  {
    key = '[',
    mods = 'LEADER',
    action = act.ActivateCopyMode,
  },
  -- -- Vim navigation between panes
  -- {
  --     key = 'h',
  --     mods = 'CTRL',
  --     action = act.ActivatePaneDirection 'Left',
  -- },
  -- {
  --     key = 'l',
  --     mods = 'CTRL',
  --     action = act.ActivatePaneDirection 'Right',
  -- },
  -- {
  --     key = 'k',
  --     mods = 'CTRL',
  --     action = act.ActivatePaneDirection 'Up',
  -- },
  -- {
  --     key = 'j',
  --     mods = 'CTRL',
  --     action = act.ActivatePaneDirection 'Down',
  -- },
  -- Enable macOS alt+leftarrow to jump one word to the left
  {
    key = 'LeftArrow',
    mods = 'ALT',
    action = act.SendString('\x1bb'),
  },
  -- Enable macOS alt+rightarrow to jump one word to the right
  {
    key = 'RightArrow',
    mods = 'ALT',
    action = act.SendString('\x1bf'),
  },
  -- Enable macOS cmd+leftarrow to jump to start of line
  {
    key = 'LeftArrow',
    mods = 'CMD',
    action = {
      SendKey = {
        key = 'a',
        mods = 'CTRL',
      },
    },
  },
  -- Enable macOS cmd+rightarrow to jump to end of line
  {
    key = 'RightArrow',
    mods = 'CMD',
    action = {
      SendKey = {
        key = 'e',
        mods = 'CTRL',
      },
    },
  },
  -- Enable macOS cmd+backspace to delete whole line
  {
    key = 'Backspace',
    mods = 'CMD',
    action = act({
      SendKey = {
        key = 'u',
        mods = 'CTRL',
      },
    }),
  },
}

-- Allow CTRL+ALT+index to move to tab to that index
for i = 1, 8 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'CTRL|ALT',
    action = act.MoveTab(i - 1),
  })
end

-- Tab formatting
wezterm.on('format-tab-title', function(tab)
  local tab_index = tab.tab_index + 1
  local formatted_title = tab.active_pane.title
  -- If the title contains a path and is truncated, append a slash at the end
  if string.match(formatted_title, '^%.%.') then
    formatted_title = formatted_title .. '/'
  elseif string.match(formatted_title, '.*/(.*)') then
    formatted_title = string.match(formatted_title, '.*/(.*)') .. '/'
  end
  local title = string.format(' %s 󰄾 %s    ', tab_index, formatted_title)
  return { { Text = title } }
end)

------- COLORS/FONTS -------
local colorscheme = 'Tokyo Night' -- Personalized colors for 'OneDark' and 'Tokyo Night'

config.color_scheme = colorscheme

local tokyonight_tab_bar_colors = {
  active_tab = {
    bg_color = '#16161f',
    fg_color = '#ffffff',
    intensity = 'Bold',
    underline = 'Single',
  },
  inactive_tab = {
    bg_color = '#16161f',
    fg_color = '#6d6d6d',
  },
  inactive_tab_hover = {
    bg_color = '#252531',
    fg_color = '#e4e4e4',
  },
  -- Plus sign to the right of tabs
  new_tab = {
    bg_color = '#16161f',
    fg_color = '#d3cede',
  },
  new_tab_hover = {
    bg_color = '#252531',
    fg_color = '#e4e4e4',
  },
}

local onedark_tab_bar_colors = {
  active_tab = {
    bg_color = '#171b20',
    fg_color = '#ffffff',
    -- these two lines below don't work for some reason
    intensity = 'Bold',
    underline = 'Single',
  },
  inactive_tab = {
    bg_color = '#171b20',
    fg_color = '#6d6d6d',
  },
  inactive_tab_hover = {
    bg_color = '#1e232a',
    fg_color = '#e4e4e4',
  },
  -- Plus sign to the right of tabs
  new_tab = {
    bg_color = '#171b20',
    fg_color = '#8e8e90',
  },
  new_tab_hover = {
    bg_color = '#1e232a',
    fg_color = '#e4e4e4',
  },
}

config.colors = {}

-- Tab bar
config.window_frame = {
  font = require('wezterm').font('MesloLGM Nerd Font'),
  -- other fonts: "DejaVu Sans", "Gujarati Sangam MN"
  font_size = 14.0,
}

if colorscheme == 'OneDark' then
  config.colors.tab_bar = onedark_tab_bar_colors
  config.window_frame.active_titlebar_bg = '#171b20' -- tab bar background
  config.colors.background = '#171b20'
  config.colors.cursor_bg = '#ffffff'
elseif colorscheme == 'Tokyo Night' then
  config.colors.tab_bar = tokyonight_tab_bar_colors
  config.colors.background = '#16161f'
  config.window_frame.active_titlebar_bg = '#16161f' -- tab bar background
end

config.font_size = 14.5
config.font = wezterm.font(
  'CaskaydiaMono Nerd Font'
  -- "JetBrainsMonoNL Nerd Font",
  -- { weight = 'Medium' }
)

------- WINDOW -------

-- Remove macOS top bar
config.window_decorations = 'RESIZE'
config.hide_tab_bar_if_only_one_tab = true
-- config.enable_tab_bar = false

-- Custom padding
config.window_padding = {
  left = 20,
  right = 15,
  top = 20,
  bottom = 0,
}

config.initial_cols = 100
config.initial_rows = 54

config.term = 'xterm-256color'

-- Return the configuration to wezterm
return config
