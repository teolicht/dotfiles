return {
  'norcalli/nvim-colorizer.lua',
  config = function()
    require('colorizer').setup({
      'html',
      'css',
      'javascript',
      'lua',
      'tmux',
    })
    -- For files not listed above
    vim.keymap.set('n', '<leader>cc', '<cmd>:ColorizerAttachToBuffer<cr>')
  end,
}
