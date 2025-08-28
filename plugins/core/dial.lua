return {
  'monaqa/dial.nvim',
  config = function()
    local augend = require 'dial.augend'

    require('dial.config').augends:register_group {

      default = {
        augend.integer.alias.decimal_int, -- nonnegative decimal number (0, 1, 2, 3, ...)
        augend.integer.alias.hex, -- nonnegative hex number  (0x06, 0x1a1f, etc.)
        augend.date.alias['%Y/%m/%d'],
        augend.constant.alias.bool,

        augend.constant.new {
          elements = { 'True', 'False' },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = { 'let', 'const' },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = { 'private', 'protected', 'public' },
          word = true,
          cyclic = true,
        },
        augend.constant.new {
          elements = { 'null', 'undefined' },
          word = true,
          cyclic = true,
        },
        augend.semver.alias.semver, -- semantic version (0.1.1, etc.)
      },
    }
  end,
}
