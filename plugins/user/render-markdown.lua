local file_types = {
  'markdown',
  'md',
  'copilot-chat',
  'Avante',
  'AvanteTodos',
}

return {
  -- enabled = false,
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'echasnovski/mini.nvim',
  },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  ft = file_types,
  opts = {
    file_types = file_types,
  },
}
