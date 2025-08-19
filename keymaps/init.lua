local utils = require 'utils'
local set_keymaps = utils.set_keymaps

-- " " Copy to clipboard
vim.cmd 'vnoremap  y  "+y'
vim.cmd 'nnoremap  Y  "+yg_'
vim.cmd 'nnoremap  y  "+y'
vim.cmd 'nnoremap  yy  "+yy'

-- " " Paste from clipboard
vim.cmd 'nnoremap p "+p'
vim.cmd 'nnoremap P "+P'
vim.cmd 'vnoremap p "+p'
vim.cmd 'vnoremap P "+P'

-- Disable q:
vim.cmd 'nnoremap q: <nop>'

local wk = require 'which-key'

wk.add {
  { '<leader>b', group = '[b]uffer' },
  { '<leader>r', group = '[r]ename' },
  { '<leader>s', group = '[s]earch' },
  { '<leader>sl', group = 'Search lsp' },
  { '<leader>h', group = '[h]arpoon' },
  { '<leader>n', group = '[n]eovim' },
  { '<leader>l', group = '[l]sp' },
  { '<leader>C', group = '[C]argo' },
  { '<leader>g', group = '[g]it' },
  { '<leader>m', group = '[m]isc' },
  { '<leader>a', group = 'Copilot Ch[a]t' },
  { '<leader>z', group = '[Z]en mode' },
}

set_keymaps(require 'keymaps.cargo')
set_keymaps(require 'keymaps.copilot')
set_keymaps(require 'keymaps.dial')
set_keymaps(require 'keymaps.git')
set_keymaps(require 'keymaps.harpoon')
set_keymaps(require 'keymaps.lsp')
set_keymaps(require 'keymaps.misc')
set_keymaps(require 'keymaps.movement')
set_keymaps(require 'keymaps.navigation')
set_keymaps(require 'keymaps.neovim')
set_keymaps(require 'keymaps.search')
set_keymaps(require 'keymaps.zen')
