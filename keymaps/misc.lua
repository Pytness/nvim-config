local utils = require 'utils'

local escape_target = function(target)
  local escapes = {
    [' '] = '%20',
    ['<'] = '%3C',
    ['>'] = '%3E',
    ['#'] = '%23',
    ['%'] = '%25',
    ['+'] = '%2B',
    ['{'] = '%7B',
    ['}'] = '%7D',
    ['|'] = '%7C',
    ['\\'] = '%5C',
    ['^'] = '%5E',
    ['~'] = '%7E',
    ['['] = '%5B',
    [']'] = '%5D',
    ['‘'] = '%60',
    [';'] = '%3B',
    ['/'] = '%2F',
    ['?'] = '%3F',
    [':'] = '%3A',
    ['@'] = '%40',
    ['='] = '%3D',
    ['&'] = '%26',
    ['$'] = '%24',
  }

  return target:gsub('.', escapes)
end

local function google_search()
  local mode = vim.api.nvim_get_mode().mode

  print('mode', mode)

  if mode == 'v' or mode == 'V' or mode == '' then
    vim.cmd 'normal! "sy'
  elseif mode == 'n' then
    vim.cmd 'normal! "syiW'
  end

  local selected_text = vim.fn.getreg 's'

  selected_text = escape_target(selected_text)

  local search_query = 'https://www.google.com/search?q=' .. selected_text

  -- wsl
  if utils.is_linux() then
    print('xdg-open ' .. search_query)
    vim.fn.jobstart('xdg-open "' .. search_query .. '"')
  elseif utils.is_wsl() then
    print('wsl-open ' .. search_query)
    vim.fn.jobstart('wsl-open "' .. search_query .. '"')
  end
end

local function eval_expression(expression)
  local handle = io.popen('echo "' .. expression .. '" | bc -l')

  if not handle then
    return nil
  end

  local result = handle:read '*a'
  handle:close()
  result = result:gsub('\n', '')

  if result == '' then
    return nil
  end

  return result
end

local function eval_selection()
  -- Yank the selected text into register 's'
  vim.cmd 'normal! "sy'

  local lines = vim.fn.getreg 's'
  local expression = lines:gsub('\n', ' ')

  local result = eval_expression(expression)

  if not result then
    print 'Error evaluating expression'
    return
  end

  -- Put the result into register 's'
  vim.fn.setreg('s', result)

  -- Replace the selected text with the result
  vim.cmd 'normal! gv"sp'
end

local function eval_input()
  local mode = vim.api.nvim_get_mode().mode

  local is_visual = mode == 'v' or mode == 'V' or mode == ''
  local expr = ''

  if is_visual then
    vim.cmd 'normal! "sy'
    expr = vim.fn.getreg 's'
    expr = expr:gsub('\n', ' ')
    expr = expr:trim ' ' .. ' '
  end

  local expression = vim.fn.input('Enter expression: ', expr)

  if expression == '' then
    print 'No expression entered'
    return
  end

  local result = eval_expression(expression)

  if not result then
    print 'Error evaluating expression'
    return
  end

  -- Put the result into register 's'
  vim.fn.setreg('s', result)

  if is_visual then
    vim.cmd 'normal! gv"sp'
  else
    vim.cmd 'normal! "sp'
  end
end

return {
  { 'n', 'ygG', 'ggVGy', { desc = 'Yank whole buffer' } },
  { { 'n', 'v' }, 'gS', google_search, { desc = 'Search on google' } },

  { { 'n', 'x' }, '<leader>ms', "<cmd>'<,'>sort<cr>", { desc = 'Sort lines' } },
  { 'n', '<leader>mm', '<cmd>MarkdownPreviewToggle<cr>', { desc = 'Toggle markdown preview' } },
  { 'v', '<leader>me', eval_selection, { desc = 'Eval selection using bc' } },
  { { 'n', 'v' }, '<leader>mc', eval_input, { desc = 'Open calc with input' } },
}
