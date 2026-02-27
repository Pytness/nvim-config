return {
  'obsidian-nvim/obsidian.nvim',
  version = '*', -- use latest release, remove to use latest commit
  cmd = { 'Obsidian' },
  ft = 'markdown',
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false, -- this will be removed in the next major release
    workspaces = {
      {
        name = 'License',
        path = '~/obsidian/license/',
      },
    },
    note_id_func = function(title)
      if title ~= nil and title ~= '' then
        return title
      else
        local suffix = ''
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
        return os.date '%Y-%m-%d' .. ' ' .. suffix
      end
    end,
  },
}
