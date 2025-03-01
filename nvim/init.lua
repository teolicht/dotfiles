vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true

-- Disable mouse mode because it makes it impossible to copy a selection in SSH.
-- Enable it with `set mouse=<option>`in order to resize splits if necessary
vim.opt.mouse = ''

-- * Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- * Enable break indent
vim.opt.breakindent = true

-- * Save undo history
vim.opt.undofile = true

-- Disable netrw for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Writing "smart" will also find "Smart"
vim.opt.ignorecase = true
-- Writing "Smart" will ONLY find "Smart"
vim.opt.smartcase = true

-- * Show which line your cursor is on
vim.opt.cursorline = true

-- Scroll down when there are 10 lines remaining
vim.opt.scrolloff = 10

-- Decrease update time
vim.opt.updatetime = 250

-- * Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- * Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- * Preview substitutions live while typing
vim.opt.inccommand = 'split'

-- Set 4 spaces for indentation
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Enable 24-bit RGB color
vim.opt.termguicolors = true

-- Yank highlight
vim.cmd([[
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup='IncSearch', timeout=100}
augroup END
]])

-- Sync clipboard between OS and Neovim
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Detect all F# files
vim.cmd([[
  autocmd BufRead,BufNewFile *.fs,*.fsi set filetype=fsharp
]])

-- Automatically run .stylua.toml when saving lua file
-- vim.api.nvim_create_autocmd('BufWritePre', {
--    pattern = '*.lua',
--    callback = function()
--       vim.cmd('!stylua %')
--       vim.cmd('edit!')
--    end,
-- })

-- [[ Basic Keymaps ]] --

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set(
  'n',
  '<leader>q',
  vim.diagnostic.setloclist,
  { desc = 'Open diagnostic [Q]uickfix list' }
)
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)

-- Make split navigation easier
vim.keymap.set(
  'n',
  '<C-h>',
  '<C-w><C-h>',
  { desc = 'Move focus to the left window' }
)
vim.keymap.set(
  'n',
  '<C-l>',
  '<C-w><C-l>',
  { desc = 'Move focus to the right window' }
)
vim.keymap.set(
  'n',
  '<C-j>',
  '<C-w><C-j>',
  { desc = 'Move focus to the lower window' }
)
vim.keymap.set(
  'n',
  '<C-k>',
  '<C-w><C-k>',
  { desc = 'Move focus to the upper window' }
)

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    lazyrepo,
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require('lazy').setup({
  spec = {
    { import = 'plugins' },
  },
  checker = { enabled = false },
  change_detection = {
    notify = false,
  },
})

-- Load colorscheme
vim.cmd('colorscheme tokyonight-night')
