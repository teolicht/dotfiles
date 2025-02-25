local treesitter = function()
  require('nvim-treesitter.configs').setup({
    build = ':TSUpdate',
    ensure_installed = {
      'bash',
      'diff',
      'html',
      'css',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'vim',
      'vimdoc',
      'python',
      'c_sharp',
    },
    ignore_install = { 'latex' },
    -- Autoinstall languages that are not installed
    auto_install = true,
    highlight = {
      enable = true,
    },
    indent = { enable = true },
  })
  -- Fix treesitter not applying highlighting to Markdown C# code blocks
  vim.treesitter.language.register('c_sharp', 'csharp')
end
-- There are additional nvim-treesitter modules that you can use to interact
-- with nvim-treesitter. You should go explore a few and see what interests you:
--
--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects

local autotag = function()
  require('nvim-ts-autotag').setup({
    opts = {
      -- Defaults
      enable_close = true, -- Auto close tags
      enable_rename = true, -- Auto rename pairs of tags
      enable_close_on_slash = false, -- Auto close on trailing </
    },
  })
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    config = treesitter,
  },
  {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
    config = autotag,
  },
}
