function _G.get_oil_winbar()
  local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  local dir = require('oil').get_current_dir(bufnr)

  if dir then
    -- Replace OneDrive path with ~/Uni
    dir = dir:gsub(
      '^/Users/teolicht/Library/CloudStorage/OneDrive%-UniversityofCopenhagen',
      '~/Uni'
    )
    return vim.fn.fnamemodify(dir, ':~')
  else
    return vim.api.nvim_buf_get_name(0)
  end
end

local config = function()
  require('oil').setup({
    columns = { 'icon' },
    default_file_explorer = true,
    watch_for_changes = true, -- Watch for changes in the file system
    delete_to_trash = true,
    view_options = {
      show_hidden = false, -- Default option
    },
    keymaps = {
      ['<C-h>'] = false, -- Disable default keybinding for horizontal split
      ['<C-v>'] = { 'actions.select', opts = { vertical = true } }, -- Vertical split
      ['<C-b>'] = { 'actions.select', opts = { horizontal = true } }, -- Horizontal split
      -- Below are the other default keymaps
      ['g?'] = { 'actions.show_help', mode = 'n' },
      ['<CR>'] = 'actions.select',
      ['<C-t>'] = { 'actions.select', opts = { tab = true } },
      ['<C-p>'] = 'actions.preview',
      ['<C-c>'] = { 'actions.close', mode = 'n' },
      ['<C-l>'] = 'actions.refresh',
      ['-'] = { 'actions.parent', mode = 'n' },
      ['_'] = { 'actions.open_cwd', mode = 'n' },
      ['`'] = { 'actions.cd', mode = 'n' },
      ['~'] = { 'actions.cd', opts = { scope = 'tab' }, mode = 'n' },
      ['gs'] = { 'actions.change_sort', mode = 'n' },
      ['gx'] = 'actions.open_external',
      ['g.'] = { 'actions.toggle_hidden', mode = 'n' },
      ['g\\'] = { 'actions.toggle_trash', mode = 'n' },
    },
    win_options = {
      winbar = '%!v:lua.get_oil_winbar()',
    },
  })
  -- Open parent directory in current window
  vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
  -- Open parent directory in floating window
  vim.keymap.set('n', '<space>-', require('oil').toggle_float)
end

return {
  'stevearc/oil.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'echasnovski/mini.icons',
  },
  config = config,
}
