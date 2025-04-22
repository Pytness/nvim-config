vim.api.nvim_create_user_command('KulalaFromPostman', function(opts)
  local file_path = opts.args
  if file_path == '' then
    print 'Please provide a Postman collection JSON file.'
    return
  end

  local file = io.open(file_path, 'r')
  if not file then
    print('Could not open file: ' .. file_path)
    return
  end

  local content = file:read '*a'

  local data = vim.fn.json_decode(content)

  local items = data.item

  -- Create a new buffer and set it to the Kulala filetype
  vim.cmd 'enew'
  vim.bo.filetype = 'http'

  local lines = {}

  for _, item in ipairs(items) do
    local name = item.name
    local request = item.request

    local method = request.method
    local url = request.url.raw
    local headers = request.headers
    local body = request.body.raw

    -- Format the request for Kulala
    local title = string.format('### %s', name)
    local http_request = string.format('%s %s', method, url)

    table.insert(lines, title)
    table.insert(lines, http_request)

    if headers then
      for _, header in ipairs(headers) do
        local header_str = string.format('%s: %s', header.key, header.value)
        table.insert(lines, header_str)
      end
    end

    if body and #body > 0 then
      -- Add a blank line between headers and body
      table.insert(lines, '')

      local body_lines = vim.split(body, '\n')

      for _, line in ipairs(body_lines) do
        table.insert(lines, line)
      end
    end

    -- Add two blank line between requests
    table.insert(lines, '')
    table.insert(lines, '')
  end

  for index, line in ipairs(lines) do
    lines[index] = line:gsub('%s+$', '')
  end

  vim.api.nvim_buf_set_lines(0, 0, #lines, false, lines)

  -- autoformat the buffer
  vim.cmd 'normal! ggVG=gg'
end, {
  desc = 'Convert Postman collection to Kulala requests',
  nargs = '*',
  complete = 'file',
})
