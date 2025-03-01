local onedark = {
  'navarasu/onedark.nvim',
  name = 'onedark',
  priority = 1000,
  lazy = true,
  config = function()
    require('onedark').setup({
      -- Main options --
      style = 'darker', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
      transparent = false, -- Show/hide background
      term_colors = true, -- Change terminal color as per the selected theme style
      ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
      cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

      -- toggle theme style ---
      toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
      toggle_style_list = {
        'dark',
        'darker',
        'cool',
        'deep',
        'warm',
        'warmer',
        'light',
      }, -- List of styles to toggle between

      -- Change code style ---
      -- Options are italic, bold, underline, none
      -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
      code_style = {
        comments = 'italic',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none',
      },
      -- Lualine options --
      lualine = {
        transparent = false, -- lualine center bar transparency
      },

      -- Custom Highlights --
      colors = {},
      highlights = {
        -- Fix black winbar background when using nvim-navic
        WinBarNC = { bg = '#282c34' },
        WinBar = { bg = '#282c34' },
      },
      -- Plugins Config --
      diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = true, -- use undercurl instead of underline for diagnostics
        background = true, -- use background color for virtual text
      },
    })

    -- Load this colorscheme
    -- vim.cmd.colorscheme('onedark')
  end,
}

local tokyonight = {
  'folke/tokyonight.nvim',
  name = 'tokyonight',
  priority = 1000,
  lazy = false,
  config = function()
    require('tokyonight').setup({
      transparent = true,
      styles = {
        sidebars = 'transparent',
        floats = 'transparent',
      },
      style = 'night',
    })
  end,
}

local astrotheme = {
  'AstroNvim/astrotheme',
  name = 'astrotheme',
  lazy = true,
  config = function()
    require('astrotheme').setup({
      palette = 'astrodark',
    })
  end,
}

-- To load colorschemes faster. But I didn't notice significant difference and
-- color for 'NORMAL' was wrong for tokyonight
local excolors = {
  'aileot/ex-colors.nvim',
  lazy = true,
  cmd = 'ExColors',
  ---@type ExColors.Config
  opts = {},
  config = function()
    require('ex-colors').setup()
  end,
}

return {
  onedark,
  tokyonight,
  astrotheme,
}
