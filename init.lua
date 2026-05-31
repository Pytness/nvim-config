local home_dir = os.getenv 'HOME'
local nvim_dir = home_dir .. '/.config/nvim/'

package.path = nvim_dir .. '?.lua;' .. package.path
package.path = nvim_dir .. '?/?.lua;' .. package.path
package.path = nvim_dir .. '?/init.lua;' .. package.path

-- remap <f12> to 'q'
vim.api.nvim_set_keymap('n', '<F12>', 'q', { noremap = true, silent = true })
vim.keymap.set('n', 'q', '<nop>', { noremap = true, silent = true })

require 'custom.keymap_stats'
require 'libs'
require 'options'
require 'autocmd'
require 'lazy-loader'

require 'keymaps'
require 'commands'
vim.cmd 'colorscheme palenight'

vim.cmd 'packadd nvim.undotree'
