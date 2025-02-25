return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    icons = {
      mappings = vim.g.have_nerd_font,
      keys = {},
    },
    -- Document existing key chains
    spec = {
      { '<leader>f', group = '[F]ind' },
    },
  },
  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show({ global = false })
      end,
      desc = 'Buffer Local Keymaps (which-key)',
    },
  },
}
