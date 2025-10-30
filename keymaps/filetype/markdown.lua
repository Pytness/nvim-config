local function toggle_markdown_list_done()
  local line = vim.api.nvim_get_current_line()
  print(line)

  local is_open = line:match '%- %[ %]'
  local is_done = line:match '%- %[x%]'

  print(is_open, is_done)

  if is_open then
    line = line:gsub('%- %[ %]', '- [x]')
  elseif is_done then
    line = line:gsub('%- %[x%]', '- [ ]')
  end

  vim.api.nvim_set_current_line(line)
end

return {
  { 'n', '<leader><leader>', toggle_markdown_list_done, { desc = 'Toggle markdown list item done' } },
}
