local STATS_FILE = vim.fn.stdpath 'data' .. '/keymap_stats.txt'

local __keymap_set = vim.keymap.set

local keymap_counter = {}

local function get_sorted_keymaps(t, ascending)
  local sorted_keys = {}
  for key, count in pairs(t) do
    table.insert(sorted_keys, { key = key, count = count })
  end

  if ascending then
    table.sort(sorted_keys, function(a, b)
      return a.count < b.count
    end)
  else
    table.sort(sorted_keys, function(a, b)
      return a.count > b.count
    end)
  end

  return sorted_keys
end

local function read_stats_from_file(filename)
  local file = io.open(filename, 'r')
  if not file then
    return
  end

  local counter = {}
  for line in file:lines() do
    local key, count = line:match '^(.-):%s*(%d+)$'
    if key and count then
      counter[key] = tonumber(count)
    else
      print('Warning: Invalid line in stats file: ' .. line)
    end
  end

  file:close()
  return counter
end

local function write_stats_to_file(t, filename)
  local file = io.open(filename, 'w')
  if not file then
    return
  end

  for key, count in pairs(t) do
    file:write(string.format('%s: %d\n', key, count))
  end

  file:close()
end

local function save_stats()
  local local_stats = keymap_counter
  local saved_stats = read_stats_from_file(STATS_FILE) or {}

  for key, count in pairs(local_stats) do
    saved_stats[key] = (saved_stats[key] or 0) + count
  end

  write_stats_to_file(saved_stats, STATS_FILE)
  keymap_counter = {}
end

local function keymap_stats(mode, lhs, rhs, opts)
  local key = lhs

  keymap_counter[key] = 0

  __keymap_set(mode, lhs, function(...)
    keymap_counter[key] = (keymap_counter[key] or 0) + 1
    save_stats()
    if type(rhs) == 'function' then
      return rhs(...)
    else
      local replaced = vim.api.nvim_replace_termcodes(rhs, true, false, true)
      vim.api.nvim_feedkeys(replaced, 'n', true)
    end
  end, opts)
end

vim.api.nvim_create_user_command('KeymapStats', function(opts)
  local args = opts.fargs

  if #args == 0 then
    return
  end

  local command = (args[1] or 'used'):lower()
  local sorting = (args[2] or 'desc'):lower()

  local stats = read_stats_from_file(STATS_FILE) or {}
  local sorted_keys = get_sorted_keymaps(stats, sorting == 'asc')

  print 'Keymap usage statistics:'

  if command == 'used' then
    for _, entry in ipairs(sorted_keys) do
      if entry.count > 0 then
        print(string.format('%s: %d', entry.key, entry.count))
      end
    end
  elseif command == 'unused' then
    for _, entry in ipairs(sorted_keys) do
      if entry.count == 0 then
        print(string.format('%s: %d', entry.key, entry.count))
      end
    end
  else
    print 'Unknown command.'
  end
end, { desc = 'Show keymap usage statistics', nargs = '*' })

vim.keymap.set = keymap_stats
