local ms = require('vim.lsp.protocol').Methods

local M = {}

M.merge_arrays = function(...)
  local result = {}
  for _, array in ipairs { ... } do
    for _, value in ipairs(array) do
      table.insert(result, value)
    end
  end
  return result
end

-- Execute a function skiping vim.fn.confirm
M.no_confirm_execute = function(confirm_value, callback)
  local old_confirm = vim.fn.confirm

  ---@diagnostic disable-next-line: duplicate-set-field
  vim.fn.confirm = function(_, _, _)
    return confirm_value
  end

  local value = callback()

  vim.fn.confirm = old_confirm
  return value
end

-- @param module_path: string - Module path to load plugins from in the form of `path.to.module`
M.load_plugins = function(module_path)
  local plugins = {}

  local path = vim.fn.stdpath 'config' .. '/' .. module_path:gsub('%.', '/')
  local files = vim.fs.dir(path)

  if not files then
    return plugins
  end

  for file_name in files do
    file_name = file_name:gsub('.lua', '')
    local plugin = require(module_path .. '/' .. file_name)
    table.insert(plugins, plugin)
  end

  return plugins
end

M.is_docker = function()
  -- Docker containers creates .dockerenv file in the root directory
  return vim.fn.filereadable '/.dockerenv' == 1
end

M.is_linux = function()
  return vim.fn.has 'linux' == 1
end

M.is_wsl = function()
  return vim.fn.has 'wsl' == 1
end

--- Set keymaps in Neovim
--- @param mappings table<string | table, string, string | function, table?>[]
M.set_keymaps = function(mappings)
  for _, keymap in ipairs(mappings) do
    local mode = keymap[1]
    local key = keymap[2]
    local action = keymap[3]
    local options = keymap[4] or {}

    vim.keymap.set(mode, key, action, options)
  end
end

M.close_hover = function()
  local win = vim.api.nvim_get_current_win()

  local buffer = nil

  if vim.w[win] ~= nil then
    buffer = vim.w[win][ms.textDocument_hover]
  end

  if buffer and vim.api.nvim_buf_is_valid(buffer) then
    vim.api.nvim_win_close(win, true)
  end
end

return M
