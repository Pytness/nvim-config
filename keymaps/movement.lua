local function quit()
  vim.cmd 'silent q'
end
function remote_action()
  require('leap.remote').action()
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
  { 'n', 's', '<Plug>(leap)' },
  { { 'n', 'x', 'o' }, 'gs', remote_action, { desc = 'Remote action' } },

  { { 'n', 'v' }, '[h', ':Gitsigns prev_hunk<CR>', { desc = 'Prev git hunk', noremap = true } },
  { { 'n', 'v' }, ']h', ':Gitsigns next_hunk<CR>', { desc = 'Next git hunk', noremap = true } },
}
