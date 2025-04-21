-- Buffer list preview and navigation/editing
return {
  'pytness/bafa.nvim',
  branch = 'refactor',
  opts = {
    width = 60,
    height = 10,
    title = ' Bafa',
    title_pos = 'center',
    relative = 'editor',
    border = 'rounded',
    style = 'minimal',
    diagnostics = false,
    icons = false,
    keymaps = require 'keymaps.bafa',
    noop_keys = {
      'i',
      'I',
      'a',
      'A',
      'o',
      'O',
      's',
      'S',
      'c',
      'C',
      'r',
      'u',
      'U',
    },
    -- last_used, name, number
    sorting_algorithm = 'last_used',
  },
}
