return {
  -- enabled = false,
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'echasnovski/mini.nvim',
  },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    file_types = {
      'markdown',
      'md',
      'copilot-chat',
    },
  },
}
