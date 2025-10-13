local function quit()
  vim.cmd 'silent q'
end
function remote_action()
  require('leap.remote').action()
end

local function leap_ft(key_specific_args)
  local operation_pending = vim.fn.mode(1):match '[no]'
  local common_args = {
    inputlen = 1,
    inclusive = true,

    opts = {
      labels = '',
      safe_labels = operation_pending and '' or nil,
      case_sensitive = false,
    },
  }

  return vim.tbl_deep_extend('keep', common_args, key_specific_args or {})
end

local clever = require('leap.user').with_traversal_keys
local clever_f = clever('f', 'F')
local clever_t = clever('t', 'T')

local function leap_f()
  require('leap').leap(leap_ft {
    opts = clever_f,
  })
end

local function leap_F()
  require('leap').leap(leap_ft {
    opts = clever_t,
    backward = true,
  })
end

local function leap_t()
  require('leap').leap(leap_ft {
    opts = clever_t,
    offset = -1,
  })
end

local function leap_T()
  require('leap').leap(leap_ft {
    opts = clever_t,
    backward = true,
    offset = 1,
  })
end

return {
  { 'i', 'jj', '<ESC>j', { silent = true } },
  { 'i', 'kk', '<ESC>k', { silent = true } },
  { 'i', 'kj', '<ESC>', { silent = true } },

  { 'n', '<leader>k', '<cmd>nohlsearch<CR>', { desc = 'Clear highlight' } },

  -- Disable default S key in favour of using it for surround.vim
  { 'n', 'S', '<nop>' },

  -- For some reason, neovim started spitting out errors
  -- when I tried to use '<cmd>q<cr>' here.
  { 'n', '<leader>q', quit, { desc = ':q' } },

  { 'n', '<leader>Q', '<cmd>q!<cr>', { desc = ':q!' } },
  { 'n', '<leader>w', '<cmd>w<cr>', { desc = ':w' } },
  { 'n', '<leader>W', '<cmd>SudaWrite<cr>', { desc = 'Write with root privileges' } },

  { 'v', '<leader>/', '<Plug>(comment_toggle_linewise_visual)', { desc = 'Comment line (visual)' } },
  { 'n', '<leader>/', '<Plug>(comment_toggle_linewise_current)', { desc = 'Comment line' } },
  -- Stay in Visual when indenting
  { 'v', '>', '>gv' },
  { 'v', '<', '<gv' },

  -- Leap
  { { 'n', 'x', 'o' }, 's', '<Plug>(leap)', { noremap = true } },
  { { 'n', 'x', 'o' }, 'gs', remote_action, { desc = 'Remote action' } },

  { { 'n', 'x', 'o' }, 'f', leap_f, { noremap = true } },
  { { 'n', 'x', 'o' }, 'F', leap_F, { noremap = true } },
  { { 'n', 'x', 'o' }, 't', leap_t, { noremap = true } },
  { { 'n', 'x', 'o' }, 'T', leap_T, { noremap = true } },

  { { 'n', 'v' }, '[h', ':Gitsigns prev_hunk<CR>', { desc = 'Prev git hunk', noremap = true } },
  { { 'n', 'v' }, ']h', ':Gitsigns next_hunk<CR>', { desc = 'Next git hunk', noremap = true } },
}
