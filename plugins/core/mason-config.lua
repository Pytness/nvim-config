local ensure_installed = {
  'lua_ls',
  'stylua',
  'pylsp',
  'rust_analyzer',
  'omnisharp',
  'clangd',
}

-- Aditional server to enable (installed servers are enabled automatically)
local enabled_servers = {
  'gdscript',
}

-- LSP Configuration & Plugins
return {
  'mason-org/mason-lspconfig.nvim',

  dependencies = {
    'neovim/nvim-lspconfig',
    { 'mason-org/mason.nvim', opts = {} },
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },

  opts = {},

  config = function(_, opts)
    require('mason-lspconfig').setup(opts)
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    for _, server in ipairs(ensure_installed) do
      vim.lsp.enable(server)
    end

    for _, server in ipairs(enabled_servers) do
      vim.lsp.enable(server)
    end
  end,
}
