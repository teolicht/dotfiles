local function treesitter()
  local ts = require('nvim-treesitter')

  ts.setup()

  ts.install({
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
  })

  vim.api.nvim_create_autocmd('FileType', {
    pattern = {
      'bash',
      'diff',
      'html',
      'css',
      'lua',
      'markdown',
      'vim',
      'python',
      'cs',
    },
    callback = function()
      vim.treesitter.start()
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })

  -- Make ```csharp Markdown code blocks use the c_sharp parser
  vim.treesitter.language.register('c_sharp', 'csharp')
end

local function autotag()
  require('nvim-ts-autotag').setup({
    opts = {
      enable_close = true,
      enable_rename = true,
      enable_close_on_slash = false,
    },
  })
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = treesitter,
  },

  {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
    config = autotag,
  },
}
