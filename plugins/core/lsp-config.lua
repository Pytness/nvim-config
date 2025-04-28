-- LSP Configuration & Plugins
return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPost', 'BufNewFile' },
  cmd = { 'LspInfo', 'LspInstall', 'LspUninstall' },
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for neovim
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'saghen/blink.cmp',

    -- Useful status updates for LSP.
    { 'j-hui/fidget.nvim', opts = {} },
  },

  config = function(_, opts)
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local border = "rounded"

        local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

        ---@diagnostic disable-next-line: duplicate-set-field
        vim.lsp.util.open_floating_preview = function(contents, syntax, _opts, ...)
          _opts = _opts or {}
          _opts.border = _opts.border or border
          return orig_util_open_floating_preview(contents, syntax, opts, ...)
        end

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })

    require('mason').setup()

    local ensure_installed = {
      'lua_ls',
      'pylsp',
      'rust_analyzer',
      'omnisharp',
      'clangd',
    }

    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
      ensure_installed = ensure_installed,
      automatic_installation = true,
    }

    require('mason-lspconfig').setup_handlers {
      function(name)
        vim.lsp.enable(name)
      end
    }
  end,
}
