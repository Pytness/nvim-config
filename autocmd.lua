local set_buf_keymaps = require('utils').set_buf_keymaps

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Disable auto-commenting on all filetypes',
  pattern = '*',
  callback = function()
    vim.opt_local.formatoptions:remove { 'r', 'o' }
  end,
})

local filetype_keymaps_group = vim.api.nvim_create_augroup('filetype_keymaps', { clear = true })
local markdown_keymaps = require 'keymaps.filetype.markdown'

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown' }, -- here you can add additional filetypes
  callback = function(event)
    local bufnr = event.buf

    set_buf_keymaps(bufnr, markdown_keymaps)
  end,
  group = filetype_keymaps_group,
})
