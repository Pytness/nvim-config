local gittools = require 'custom.gittools'
local gitbug = require 'custom.gitbug'

-- git restore current file and reload it
local function restore_current_file()
  local current_file = vim.api.nvim_buf_get_name(0)

  gittools.restore_file(current_file)
  print('Restored ' .. current_file)

  vim.cmd 'edit!'
end

local function git_diff()
  local current_file = vim.api.nvim_buf_get_name(0)
  vim.cmd('DiffviewOpen -- ' .. current_file)
  vim.cmd 'DiffviewToggleFiles'
end

return {
  { 'n', '<leader>gr', restore_current_file, { desc = 'Restore current file' } },
  { 'n', '<leader>gd', git_diff, { desc = 'Diff current file' } },
  { 'n', '<leader>gb', '<cmd>GitMessenger<cr>', { desc = 'Git blame' } },
  { 'n', '<leader>gi', gitbug.pick, { desc = 'Open git-bug issues' } },
  { 'n', '<leader>gI', function() gitbug.pick { all = true } end, { desc = 'All git-bug issues' } },
}
