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
    vim.g.vimtex_view_skim_activate = 0
    vim.g.vimtex_view_no_select = 1

    vim.g.vimtex_compiler_latexmk = {
      continuous = 1,
      options = {
        '-verbose',
        '-file-line-error',
        '-shell-escape',
        '-interaction=nonstopmode',
        '-synctex=1',
      },
    }

    -- Math environment zone color
    vim.api.nvim_set_hl(0, "texMathDelimZoneTI", {
        fg = "#e5c07b",
    })
    vim.api.nvim_set_hl(0, "texMathZoneTI", {
        fg = "#e5c07b",
    })

    --- Disable annoying quickfix pane
    vim.g.vimtex_quickfix_mode = 0

    --- All this below is Claude's code, it was the only way I could make texlab
    --- show diagnostic in-line, while also not opening stupid error pane
    local ns = vim.api.nvim_create_namespace('vimtex_log_diag')

    vim.api.nvim_create_autocmd('User', {
      pattern = 'VimtexEventCompileFailed',
      callback = function()
        vim.diagnostic.reset(ns)
        local by_buf = {}
        for _, d in ipairs(vim.diagnostic.fromqflist(vim.fn.getqflist())) do
          if d.bufnr and vim.api.nvim_buf_is_loaded(d.bufnr) then
            by_buf[d.bufnr] = by_buf[d.bufnr] or {}
            table.insert(by_buf[d.bufnr], d)
          end
        end
        for bufnr, diags in pairs(by_buf) do
          vim.diagnostic.set(ns, bufnr, diags)
        end
      end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'VimtexEventCompileSuccess',
      callback = function() vim.diagnostic.reset(ns) end,
    })

    local timer = vim.uv.new_timer()
    vim.api.nvim_create_autocmd({ 'TextChangedI', 'TextChanged' }, {
      pattern = '*.tex',
      callback = function()
        timer:stop()
        timer:start(400, 0, vim.schedule_wrap(function()
          if vim.bo.modified then
            vim.cmd('silent! write')
          end
        end))
      end,
    })

  end,
}
