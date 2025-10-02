-- Add ai autocompletion
return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup {
      copilot_model = 'gpt-4o-copilot',
      suggestion = {
        auto_trigger = true,
        accept = '<M-l>',
      },
      filetypes = {
        ['*'] = true,
      },
    }
  end,
}
