return {
  'lervag/vimtex',
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- To make Skim inverse search work with Vimtex:
    -- 1. Skim -> Settings -> Sync
    -- 2. Under 'PDF-TeX Sync Support': choose Preset -> Custom
    -- 3. Command: /opt/homebrew/bin/nvim
    -- 4. Arguments: --headless -c "VimtexInverseSearch %line '%file'"
    -- 5. Shift+Command+Click anywhere on PDF file, and cursor on Neovim should jump there
    vim.g.vimtex_view_method = 'skim'
    vim.g.vimtex_compiler_latexmk = {
      options = {
        '-shell-escape',
        '-interaction=nonstopmode',
        '-synctex=1',
      },
    }
  end,
}
