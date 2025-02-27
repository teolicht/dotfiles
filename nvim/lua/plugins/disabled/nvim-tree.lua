return {
  'nvim-tree/nvim-tree.lua',
  lazy = true,
  config = function()
    require('nvim-tree').setup({
      hijack_cursor = true,
    })
  end,
  -- NvimTree is only loaded when pressing this keymap
  keys = {
    { '<leader>e', '<cmd>NvimTreeToggle<cr>', desc = 'Toggle NvimTree' },
  },
}
