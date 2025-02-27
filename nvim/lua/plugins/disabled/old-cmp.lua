local cmp_cfg = function()
  -- Fix highlight colors for cmp menu
  vim.api.nvim_set_hl(0, 'PmenuSel', { bg = '#282C34', fg = 'NONE' })
  vim.api.nvim_set_hl(0, 'Pmenu', { fg = '#C5CDD9', bg = '#22252A' })

  local cmp = require('cmp')
  local luasnip = require('luasnip')

  -- Make autopairs work with nvim-cmp
  cmp.event:on(
    'confirm_done',
    require('nvim-autopairs.completion.cmp').on_confirm_done()
  )

  luasnip.config.setup({})

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    completion = { completeopt = 'menu,menuone,noinsert' },
    window = {
      completion = {
        border = 'rounded',
        winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
        col_offset = -3,
        side_padding = 0,
      },
      documentation = cmp.config.window.bordered(),
    },
    -- From https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance
    formatting = {
      fields = { 'kind', 'abbr', 'menu' },
      format = function(entry, vim_item)
        local kind = require('lspkind').cmp_format({
          mode = 'symbol_text',
          maxwidth = 50,
        })(entry, vim_item)
        local strings = vim.split(kind.kind, '%s', { trimempty = true })
        kind.kind = ' ' .. (strings[1] or '') .. ' '
        kind.menu = '    (' .. (strings[2] or '') .. ')'
        return kind
      end,
    },
    mapping = cmp.mapping.preset.insert({
      -- Select the [n]ext item
      ['<C-n>'] = cmp.mapping.select_next_item(),
      -- Select the [p]revious item
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      -- Scroll the documentation window [b]ack / [f]orward
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      -- Accept ([y]es) the completion.
      ['<C-y>'] = cmp.mapping.confirm({ select = true }),
      -- Traditional keymaps
      --['<CR>'] = cmp.mapping.confirm { select = true },
      --['<Tab>'] = cmp.mapping.select_next_item(),
      --['<S-Tab>'] = cmp.mapping.select_prev_item(),

      -- Manually trigger a completion from nvim-cmp.
      ['<C-Space>'] = cmp.mapping.complete({}),

      -- <c-l> will move to the right of each of the expansion locations.
      -- <c-h> is similar, except it moves backwards.
      ['<C-l>'] = cmp.mapping(function()
        if luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        end
      end, { 'i', 's' }),
      ['<C-h>'] = cmp.mapping(function()
        if luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        end
      end, { 'i', 's' }),
      -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
      --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
    }),
    sources = {
      {
        name = 'lazydev',
        -- Set group index to 0 to skip loading LuaLS completions as lazydev recommends it
        group_index = 0,
      },
      { name = 'nvim_lsp' },
      { name = 'nvim_lsp_signature_help' },
      { name = 'luasnip' },
      { name = 'buffer' },
      { name = 'path' },
    },
  })
  -- Autocompletion when using cmdline
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' },
    }, {
      {
        name = 'cmdline',
        option = {
          ignore_cmds = { 'Man', '!' },
        },
      },
    }),
  })
end

local autopairs_cfg = function()
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
end

return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    -- Snippet engine & its associated nvim-cmp source
    {
      'L3MON4D3/LuaSnip',
      build = (function()
        -- Build Step is needed for regex support in snippets.
        -- This step is not supported in many windows environments.
        -- Remove the below condition to re-enable on windows.
        if vim.fn.has('win32') == 1 or vim.fn.executable('make') == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      dependencies = {
        {
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
          end,
        },
      },
    },
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-path',
    -- 'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'onsails/lspkind.nvim',
    {
      'windwp/nvim-autopairs',
      event = 'InsertEnter',
      config = autopairs_cfg,
    },
  },
  config = cmp_cfg,
}
