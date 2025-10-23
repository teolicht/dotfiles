local blink = {
  'saghen/blink.cmp',
  dependencies = 'rafamadriz/friendly-snippets',
  version = '*',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept, C-n/C-p for up/down)
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys for up/down)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    --
    -- C-space: Open menu or open docs if already open
    -- C-e: Hide menu
    -- C-k: Toggle signature help
    keymap = {
      preset = 'default',
      ['<C-k'] = {},
      ['<C-s>'] = { 'show_signature', 'hide_signature', 'fallback' },
    },

    cmdline = {
      completion = {
        menu = { auto_show = true },
        -- Doesn't seem to be working
        ghost_text = { enabled = true },
      },
    },

    completion = {
      menu = {
        auto_show = true,
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 1000,
        window = {
          border = 'rounded',
        },
      },
      -- For a less pop-up'y configuration:
      --    > set completion.menu.autoshow = false
      --    > set completion.ghost_text.enabled = true
    },

    signature = {
      enabled = true,
      window = {
        -- show_documentation = true,
      },
    },

    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- Will be removed in a future release
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono',
    },

    sources = {
      default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
      },
    },

    fuzzy = { implementation = 'prefer_rust_with_warning' },
  },
  opts_extend = { 'sources.default' },
}

local autopairs = {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function()
    local ap = require('nvim-autopairs')
    local Rule = require('nvim-autopairs.rule')
    ap.setup({
      -- Disable entirely on txt files
      disable_filetype = { 'text' },
      -- Press <ALT-e> to wrap pair around some text
      fast_wrap = {
        map = '<M-f>',
      },
    })
    -- Don't want string pairs anywhere
    ap.remove_rule('"')
    ap.remove_rule("'")
    ap.remove_rule('(')
    ap.remove_rule(')')
    -- Example: to add rule ONLY on Python filetype
    ap.add_rule(Rule('"""', '"""', 'python'))
    -- Example: to remove double-quote rule ONLY on Python filetype
    -- ap.get_rules('"')[1].not_filetypes = { 'python' }
  end,
}

return { blink, autopairs }
