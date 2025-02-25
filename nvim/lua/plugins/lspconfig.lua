local config = function()
  -- local navic = require('nvim-navic')

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup(
      'kickstart-lsp-attach',
      { clear = true }
    ),
    callback = function(event)
      local client = vim.lsp.get_client_by_id(event.data.client_id)

      -- UNCOMMENT LINES BELOW TO RE-ENABLE LSP BREADCRUMBS
      -- -- Attach nvim-navic to the client and buffer
      -- local filetype = vim.bo[event.buf].filetype
      -- -- These if-statements are because nvim-navic can only attach to one server
      -- if filetype == 'fsharp' then
      --   if client.name == 'fsautocomplete' then
      --     navic.attach(client, event.buf)
      --   end
      -- else
      --   if filetype == 'python' then
      --     if client.name == 'pyright' then
      --       navic.attach(client, event.buf)
      --     end
      --   end
      -- end

      -- To simplify keymappings
      local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(
          mode,
          keys,
          func,
          { buffer = event.buf, desc = 'LSP: ' .. desc }
        )
      end

      map('K', vim.lsp.buf.hover, 'Display hover information')

      -- Jump to the definition of the word under your cursor.
      map(
        'gd',
        require('telescope.builtin').lsp_definitions,
        '[G]oto [D]efinition'
      )

      -- Find references for the word under your cursor.
      map(
        'gr',
        require('telescope.builtin').lsp_references,
        '[G]oto [R]eferences'
      )

      -- Jump to the implementation of the word under your cursor.
      map(
        'gI',
        require('telescope.builtin').lsp_implementations,
        '[G]oto [I]mplementation'
      )

      -- Jump to the type of the word under your cursor.
      map(
        '<leader>D',
        require('telescope.builtin').lsp_type_definitions,
        'Type [D]efinition'
      )

      -- Fuzzy find all the symbols in your current document.
      map(
        '<leader>ds',
        require('telescope.builtin').lsp_document_symbols,
        '[D]ocument [S]ymbols'
      )

      -- Fuzzy find all the symbols in your current workspace.
      map(
        '<leader>ws',
        require('telescope.builtin').lsp_dynamic_workspace_symbols,
        '[W]orkspace [S]ymbols'
      )

      -- Rename the variable under your cursor.
      map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

      -- Execute a code action, usually your cursor needs to be on top of an error
      -- or a suggestion from your LSP for this to activate.
      map(
        '<leader>ca',
        require('actions-preview').code_actions,
        '[C]ode [A]ction'
      )

      -- WARN: This is not Goto Definition, this is Goto Declaration.
      map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

      -- When you move your cursor, the highlights will be cleared (the second autocommand).
      if
        client
        and client.supports_method(
          vim.lsp.protocol.Methods.textDocument_documentHighlight
        )
      then
        local highlight_augroup = vim.api.nvim_create_augroup(
          'kickstart-lsp-highlight',
          { clear = false }
        )
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd('LspDetach', {
          group = vim.api.nvim_create_augroup(
            'kickstart-lsp-detach',
            { clear = true }
          ),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds({
              group = 'kickstart-lsp-highlight',
              buffer = event2.buf,
            })
          end,
        })
      end

      -- Toggle inlay hints
      if
        client
        and client.supports_method(
          vim.lsp.protocol.Methods.textDocument_inlayHint
        )
      then
        map('<leader>th', function()
          vim.lsp.inlay_hint.enable(
            not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
          )
        end, '[T]oggle Inlay [H]ints')
      end
    end,
  })

  -- Change diagnostic symbols in the sign column (gutter)
  if vim.g.have_nerd_font then
    local signs = { ERROR = '', WARN = '', INFO = '', HINT = '' }
    local diagnostic_signs = {}
    for type, icon in pairs(signs) do
      diagnostic_signs[vim.diagnostic.severity[type]] = icon
    end
    vim.diagnostic.config({ signs = { text = diagnostic_signs } })
  end

  -- Make docs look better
  vim.lsp.util.stylize_markdown = function(bufnr, contents, opts)
    contents = vim.lsp.util._normalize_markdown(contents, {
      width = vim.lsp.util._make_floating_popup_size(contents, opts),
    })
    vim.bo[bufnr].filetype = 'markdown'
    vim.treesitter.start(bufnr)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, contents)
    return contents
  end

  -- Create new capabilities with nvim-cmp and brodacast to LSP servers
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend(
    'force',
    capabilities,
    require('cmp_nvim_lsp').default_capabilities()
  )

  -- Servers list
  local servers = {
    -- PYTHON --
    --> pyright for completion only
    pyright = {
      init_options = {
        settings = {
          pyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
          },
          python = {
            analysis = {
              ignore = { '*' }, -- using ruff
              typeCheckingMode = 'off', -- using mypy
            },
          },
        },
      },
      on_attach = function(client)
        -- Disable diagnostics from pyright because using ruff
        client.handlers['textDocument/publishDiagnostics'] = function() end
      end,
    },
    --> ruff for diagnostics, linting and formatting
    ruff = {},
    -- LUA --
    lua_ls = {},
    stylua = {},
  }

  -- Enable mypy for Python type checking
  local null_ls = require('null-ls')
  null_ls.setup({
    sources = {
      null_ls.builtins.diagnostics.mypy.with({
        method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
        extra_args = {
          '--show-column-numbers',
          '--check-untyped-defs',
          '--warn-no-return',
          '--warn-return-any',
          '--warn-unreachable',
        },
      }),
    },
  })

  -- Mason setup
  require('mason').setup()
  local ensure_installed = vim.tbl_keys(servers or {})
  require('mason-tool-installer').setup({ ensure_installed = ensure_installed })
  require('mason-lspconfig').setup({
    handlers = {
      function(server_name)
        local server = servers[server_name] or {}
        server.capabilities = vim.tbl_deep_extend(
          'force',
          {},
          capabilities,
          server.capabilities or {}
        )
        require('lspconfig')[server_name].setup(server)
      end,
    },
  })
end

-- Add round border around vim.lsp.buf.hover()
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover, { border = 'rounded' }
)

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'jose-elias-alvarez/null-ls.nvim',
    'aznhe21/actions-preview.nvim'
  },
  config = config,
}
