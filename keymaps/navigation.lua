--  Use CTRL+<hjkl> to switch between windows

local function toggle_minifiles()
  require('custom.minifiles').toggle()
end

local function toggle_bafa()
  require('bafa.ui').toggle()
end

return {
  { 'n', '<leader>e', toggle_minifiles, { desc = 'Toggle file tree' } },
  { 't', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' } },
  { 'n', '<leader>tt', '<cmd>terminal<cr>', { desc = 'Toggle terminal' } },

  { 'n', '<leader>sb', toggle_bafa, { desc = 'Close diffview' } },
  { 'n', '<leader>bn', '<cmd>bnext<cr>', { desc = 'Next buffer' } },
  { 'n', '<leader>bb', '<cmd>bprev<cr>', { desc = 'Previous buffer' } },

  { 'n', '<leader>c', '<cmd>BufDel<cr>', { desc = 'Close Buffer' } },
}
