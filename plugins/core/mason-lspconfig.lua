return {
  'mason-org/mason-lspconfig.nvim',
  opts = {
    automatic_enable = true,
  },
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    'neovim/nvim-lspconfig',
  },
}
-- require('mason-lspconfig').setup {
--   -- ensure_installed = ensure_installed,
--   -- automatic_installation = true,
--   -- automatic_enable = true,
-- }
