-- LSP clients attached to buffer
local clients_lsp = function()
  local clients =
    vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
  if next(clients) == nil then
    return ''
  end

  local c = {}
  for _, client in pairs(clients) do
    table.insert(c, client.name)
  end
  return '  ' .. table.concat(c, ', ')
end

local config = function()
  require('lualine').setup({
    -- options = { theme = 'onedark' },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = { 'filename' },
      lualine_x = { clients_lsp, 'filetype' },
    },
    -- winbar = {
    --   lualine_c = {
    --     'navic',
    --     color_correction = nil,
    --     navic_opts = nil,
    --   },
    -- },
  })
end

return {
  'nvim-lualine/lualine.nvim',
  config = config,
}
