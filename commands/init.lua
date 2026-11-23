vim.api.nvim_create_user_command('GitBug', function(args)
  local gitbug = require 'custom.gitbug'

  if args.args == 'all' then
    gitbug.pick { all = true }
  elseif args.args ~= '' then
    gitbug.show(args.args)
  else
    gitbug.pick()
  end
end, { nargs = '?', desc = 'Browse git-bug issues (all | <id>)' })
