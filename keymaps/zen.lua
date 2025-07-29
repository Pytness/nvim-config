---@param start_line number
---@param end_line number
local function get_folds(start_line)
  local folds = {}

  local last_line = vim.api.nvim_buf_line_count(0)
  local line_number = start_line - 1 or 1

  while line_number <= last_line do
    local start_fold = vim.fn.foldclosed(line_number)
    if start_fold ~= -1 then
      local end_fold = vim.fn.foldclosedend(line_number)
      table.insert(folds, { start_fold, end_fold })
      line_number = end_fold + 1
    else
      line_number = line_number + 1
    end
  end

  return folds
end

---@param start_line number
---@param end_line number
local function get_adjusted_range(start_line, end_line)
  local folds = get_folds(start_line)

  local range_start = start_line
  local range_end = end_line

  for _, fold in ipairs(folds) do
    if fold[1] < range_start and fold[2] >= range_start then
      range_start = fold[2] + 1
    end
    if fold[1] > range_end then
      range_end = fold[1] - 1
    end
  end

  return range_start, range_end
end

---@param start_line number
---@param end_line number
local function correct_cursor(start_line, end_line)
  local range_start, range_end = get_adjusted_range(start_line, end_line)

  local cursor = vim.api.nvim_win_get_cursor(0)
  local current_line = cursor[1]
  local current_col = cursor[2]

  local target_line = current_line

  if current_line < range_start then
    target_line = range_start
  elseif current_line > range_end then
    target_line = range_end
  end

  vim.schedule(function()
    vim.api.nvim_win_set_cursor(0, { target_line, current_col })
  end)
end

---@param bufnr number
---@param start_line number
---@param end_line number
local function create_autocmds(bufnr, start_line, end_line)
  vim.api.nvim_create_augroup('FocusCursorMoved', { clear = true })

  vim.api.nvim_create_autocmd('CursorMoved', {
    buffer = bufnr,
    group = 'FocusCursorMoved',
    callback = function()
      correct_cursor(start_line, end_line)
    end,
  })

  vim.api.nvim_create_autocmd('CursorMovedI', {
    buffer = bufnr,
    group = 'FocusCursorMoved',
    callback = function()
      correct_cursor(start_line, end_line)
    end,
  })
end

local function focus()
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
      local bufnr = vim.api.nvim_win_get_buf(win)

      create_autocmds(bufnr, start_line, end_line)
    end,

    on_close = function()
      vim.api.nvim_clear_autocmds { group = 'FocusCursorMoved' }
    end,
  }
end

return {
  { 'v', '<leader>F', focus, { desc = 'Narrow focus' } },
}
