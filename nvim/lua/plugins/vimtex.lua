return {
  'lervag/vimtex',
  lazy = false,     -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- VimTeX configuration
    vim.g.vimtex_view_method = 'skim'
    vim.g.vimtex_compiler_latexmk = {
      options = {
        '-shell-escape',
        '-interaction=nonstopmode',
        '-synctex=1'
      }
    }
  end
}
