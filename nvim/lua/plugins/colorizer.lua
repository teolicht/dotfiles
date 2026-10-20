local colorizer = {
  'catgoose/nvim-colorizer.lua',
  config = function()
    require('colorizer').setup({
      filetypes = {
        'html',
        'css',
        'javascript',
        'lua',
        'tmux',
        'bash',
        'sh',
      },
    })

    vim.keymap.set(
      'n',
      '<leader>cc',
      '<cmd>ColorizerToggle<cr>',
      { desc = 'Toggle colorizer' }
    )
  end,
}

local todo = {
  'folke/todo-comments.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {},
}

return { colorizer, todo }
