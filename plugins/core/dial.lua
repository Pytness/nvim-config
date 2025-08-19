local utils = require 'utils'

return {
  'monaqa/dial.nvim',
  config = function(opts)
    local augend = require 'dial.augend'
    require('dial.config').augends:register_group {
      -- default augends used when no group name is specified
      default = {
        augend.integer.alias.decimal_int, -- nonnegative decimal number (0, 1, 2, 3, ...)
        augend.integer.alias.hex, -- nonnegative hex number  (0x06, 0x1a1f, etc.)
        augend.date.alias['%Y/%m/%d'], -- date (2022/1/29, etc.)
        augend.constant.alias.bool, -- boolean value (true <-> false)
      },
    }
  end,
}
