-- Allows you to jump to any character in the visible area of the screen
return {
  'ggandor/leap.nvim',

  opts = {
    safe_labels = '', -- Disable the default labels so keypresses are always 3
    labels = 'sfnjklhodweimbuyvrgtaqpcxz',
  },

  config = function(_, opts)
    require('leap.user').set_repeat_keys(';', ',', {
      relative_directions = true,
      modes = { 'n', 'x', 'o' },
    })
  end,
}
