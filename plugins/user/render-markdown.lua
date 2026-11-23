local file_types = {
  'markdown',
  'md',
  'copilot-chat',
}

return {
  -- enabled = false,
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-mini/mini.nvim',
  },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  ft = file_types,
  opts = {
    file_types = file_types,
  },
}
