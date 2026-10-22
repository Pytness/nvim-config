-- Allows you to jump to any character in the visible area of the screen
return {
  'https://codeberg.org/andyg/leap.nvim',

  -- THEY KEEP FUCKING CHANGING THE DEFAULTS AND BEHAVIOUR.
  commit = '277e04fa',

  opts = {
    -- By default, the equivalence classes include:
    -- { ' \t\r\n', '([{', ')]}', '\'"`' }
    -- Im only interested in whitespace.
    equivalence_classes = { '\t\r\n' },
    safe_labels = '', -- Disable the default labels so keypresses are always 3
    labels = 'asdfghjkl;qwertyoiup',

    offset_labels = true,
  },

  config = function(_, opts)
    require('leap.user').set_repeat_keys(';', ',', {
      relative_directions = true,
      modes = { 'n', 'x', 'o' },
    })

    require('leap').setup(opts)
  end,
}
