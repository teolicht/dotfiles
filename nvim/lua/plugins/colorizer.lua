local colorizer = {
  'norcalli/nvim-colorizer.lua',
  config = function()
    require('colorizer').setup({
      'html',
      'css',
      'javascript',
      'lua',
      'tmux',
      'bash',
      'sh',
    })
    -- For files not listed above
    vim.keymap.set('n', '<leader>cc', '<cmd>:ColorizerAttachToBuffer<cr>')
  end,
}

local todo = {
  'folke/todo-comments.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {},
}

return { colorizer, todo }
