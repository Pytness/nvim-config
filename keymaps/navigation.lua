--  Use CTRL+<hjkl> to switch between windows

local function toggle_minifiles()
  require('custom.minifiles').toggle()
end

local function open_current_buffer_on_minifiles()
  require('custom.minifiles').open_current_buffer()
end

local function toggle_bafa()
  require('bafa.ui').toggle()
end

return {
  { 'n', '<leader>e', toggle_minifiles, { desc = 'Toggle file tree' } },
  { 'n', '<leader>E', open_current_buffer_on_minifiles, { desc = 'Open current buffer in file tree' } },

  { 't', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' } },
  { 'n', '<leader>tt', '<cmd>terminal<cr>', { desc = 'Toggle terminal' } },

  { 'n', '<leader>sb', toggle_bafa, { desc = 'Close diffview' } },
  { 'n', '<leader>bn', '<cmd>bnext<cr>', { desc = 'Next buffer' } },
  { 'n', '<leader>bb', '<cmd>bprev<cr>', { desc = 'Previous buffer' } },

  { 'n', '<leader>c', '<cmd>BufDel<cr>', { desc = 'Close Buffer' } },
}
