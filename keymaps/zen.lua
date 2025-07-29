function focus(data)
  local cursor = vim.api.nvim_win_get_cursor(0)

  local start_line = cursor[1]
  local end_line = vim.fn.line 'v'

  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end

  local line_count = end_line - start_line + 1

  -- exit visual mode with feedkeys
  local esc = vim.api.nvim_replace_termcodes('<Esc>', true, false, true)
  vim.api.nvim_feedkeys(esc, 'n', true)

  print('Focus lines:', start_line, end_line)
  print('Line count:', line_count)

  require('focus').toggle {
    line1 = start_line,
    line2 = end_line,

    window = {
      -- Set the cursor to the first line of the focus window
      -- The focus window includes the first and last line of the buffer
      -- as folds, so we add 2 to the height as padding
      height = line_count + 2,
    },

    on_open = function(win)
      vim.api.nvim_win_set_cursor(win, { start_line, 0 })
    end,
  }
end

return {
  { 'v', '<leader>F', focus, { desc = 'Narrow focus' } },
}
