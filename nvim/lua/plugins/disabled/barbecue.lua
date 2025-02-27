local config = function()
  require('barbecue').setup({
    attach_navic = false, -- only show path up to file itself
    create_autocmd = false, -- prevent barbecue from updating itself automatically
    exclude_filetypes = { 'oil' },
  })

  vim.api.nvim_create_autocmd({
    'WinScrolled', -- or WinResized on NVIM-v0.9 and higher
    'BufWinEnter',
    'CursorHold',
    'InsertLeave',

    -- include this if you have set `show_modified` to `true`
    -- "BufModifiedSet",
  }, {
    group = vim.api.nvim_create_augroup('barbecue.updater', {}),
    callback = function()
      require('barbecue.ui').update()
    end,
  })
end

return {
  'utilyre/barbecue.nvim',
  lazy = true,
  name = 'barbecue',
  version = '*',
  config = config,
  dependencies = {
    'SmiteshP/nvim-navic',
    lazy = true,
  },
  opts = {},
}
