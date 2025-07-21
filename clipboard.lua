local utils = require 'utils'

local function yank_to_clipboard(lines)
  local text = table.concat(lines, '\r\n')
  vim.fn.system('wclip.exe -i', text)
end

local function paste_to_clipboard()
  local text = vim.fn.system 'wclip.exe -o | sed -e "s/\r//g"'
  return text:split '\n'
end

if utils.is_docker() then
  -- TODO: Add support system clipboard when inside of docker
elseif utils.is_wsl() then
  vim.g.clipboard = {
    name = 'wsl',

    copy = {
      ['+'] = yank_to_clipboard,
      ['*'] = yank_to_clipboard,
    },

    paste = {
      ['+'] = paste_to_clipboard,
      ['*'] = paste_to_clipboard,
    },

    cache_enabled = false,
  }
elseif utils.is_linux() then
  vim.g.clipboard = {
    name = 'wl-clipboard',

    copy = {
      ['+'] = { 'wl-copy' },
      ['*'] = { 'wl-copy' },
    },

    paste = {
      ['+'] = { 'wl-paste', '-n' },
      ['*'] = { 'wl-paste', '-n' },
    },

    cache_enabled = true,
  }
end
