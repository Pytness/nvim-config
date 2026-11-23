-- Browse git-bug issues. Issues start with "Commit: <sha>" so file:line refs
-- are opened at that commit, where the lines are still correct.

--- @alias WindowType 'split' | 'tab'

local M = {}

--- Returns the top-level directory of the current git repository.
---
--- @return string? # absolute path, or nil outside a repository
local function git_root()
  local out = vim.system({ 'git', 'rev-parse', '--show-toplevel' }, { text = true }):wait()
  if out.code ~= 0 then
    return nil
  end
  return vim.trim(out.stdout)
end

--- Runs `cmd` synchronously and notifies its stderr on failure.
---
--- @param cmd string[] command and arguments
--- @param cwd string? working directory
--- @return string? # stdout, or nil if the command failed
local function run(cmd, cwd)
  local out = vim.system(cmd, { text = true, cwd = cwd }):wait()
  if out.code ~= 0 then
    vim.notify(vim.trim(out.stderr), vim.log.levels.ERROR)
    return nil
  end
  return out.stdout
end

--- Shows `lines` in a read-only scratch buffer named `name` in the current
--- window, reusing the buffer if it already exists.
---
--- @param name string buffer name
--- @param lines string[] buffer contents
--- @param ft string? filetype
--- @return integer # buffer handle
local function scratch(name, lines, ft)
  local buf = vim.fn.bufnr(name)
  if buf == -1 then
    buf = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_buf_set_name(buf, name)
  end

  vim.bo[buf].modifiable = true
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  vim.bo[buf].bufhidden = 'hide'
  vim.bo[buf].filetype = ft or ''
  vim.api.nvim_set_current_buf(buf)
  return buf
end

--- Finds the file `path` refers to in the tree at `sha`.
--- Refs may be shortened ("glyphs.rs:42"), so falls back to a suffix match.
---
--- @param root string repository root
--- @param sha string commit to look in
--- @param path string path as written in the issue
--- @return string? # repository-relative path, or nil if not found
local function resolve_path(root, sha, path)
  local files = run({ 'git', 'ls-tree', '-r', '--name-only', sha }, root)
  if not files then
    return nil
  end

  local suffix = nil
  for file in files:gmatch '[^\n]+' do
    if file == path then
      return file
    end
    if not suffix and vim.endswith(file, '/' .. path) then
      suffix = file
    end
  end
  return suffix
end

--- Follows a file renamed since `sha`, using git's rename detection.
---
--- @param root string repository root
--- @param sha string commit the path belongs to
--- @param path string repository-relative path at `sha`
--- @return string # current path, or `path` if it was not renamed
local function renamed_path(root, sha, path)
  local out = run({ 'git', 'diff', '--name-status', '-M', sha, '--' }, root) or ''
  for line in out:gmatch '[^\n]+' do
    local from, to = line:match '^R%d*\t([^\t]+)\t([^\t]+)$'
    if from == path then
      return to
    end
  end
  return path
end

--- Maps `lnum` at `sha` to the working tree by shifting it past each diff
--- hunk above it.
---
--- @param root string repository root
--- @param sha string commit `lnum` belongs to
--- @param old_path string path at `sha`
--- @param new_path string path in the working tree
--- @param lnum integer line number at `sha`
--- @return integer # line number in the working tree
--- @return boolean # whether the line itself was changed
local function follow_line(root, sha, old_path, new_path, lnum)
  local diff = run({ 'git', 'diff', '-U0', '--no-color', '--no-ext-diff', sha, '--', old_path, new_path }, root)
  if not diff then
    return lnum, false
  end

  local offset = 0
  for o_start, o_count, n_start, n_count in diff:gmatch '\n@@ %-(%d+),?(%d*) %+(%d+),?(%d*) @@' do
    local os_ = tonumber(o_start) --[[@as integer]]
    local ns = tonumber(n_start) --[[@as integer]]
    -- an omitted count means 1
    local oc = tonumber(o_count) or 1
    local nc = tonumber(n_count) or 1

    if oc == 0 then
      -- pure insertion after old line `os_`
      if os_ >= lnum then
        break
      end
    elseif lnum < os_ then
      break
    elseif lnum < os_ + oc then
      return math.max(ns, 1), true
    end
    offset = offset + nc - oc
  end
  return lnum + offset, false
end

--- Returns the `path:lnum` ref under the cursor, or the first one on the line.
---
--- @return { path: string, lnum: integer }?
local function ref_under_cursor()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2] + 1

  local first = nil
  for s, path, lnum, e in line:gmatch '()([%w_%./%-]+%.%w+):~?(%d+)()' do
    first = first or { path = path, lnum = tonumber(lnum) }
    if col >= s and col < e then
      return { path = path, lnum = tonumber(lnum) }
    end
  end
  return first
end

--- Returns the closest "Commit:" sha above the cursor, so each comment can
--- pin its own.
---
--- @return string? # sha, or nil if there is no "Commit:" line
local function commit_for_cursor()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local lines = vim.api.nvim_buf_get_lines(0, 0, row, false)
  for i = #lines, 1, -1 do
    local sha = lines[i]:match '^%s*Commit:%s*(%x+)'
    if sha then
      return sha
    end
  end
  return nil
end

--- Opens the window a ref is shown in, mirroring the <C-w> variants.
---
--- @param win WindowType? nil keeps the current window
local function open_win(win)
  if win == 'split' then
    vim.cmd 'split'
  elseif win == 'tab' then
    vim.cmd 'tab split'
  end
end

--- Opens the `path:lnum` ref under the cursor.
---
--- @param at_commit boolean true opens the file at the issue's pinned commit,
--- false opens the working tree file with the line followed across changes
--- @param win WindowType? where to open it
--- @see open_win
local function open_ref(at_commit, win)
  local root = vim.b.gitbug_root
  local ref = ref_under_cursor()

  if not ref then
    vim.notify('No file:line on this line', vim.log.levels.WARN)
    return
  end

  local sha = commit_for_cursor()
  if at_commit and not sha then
    vim.notify('Issue has no Commit: line, opening working tree', vim.log.levels.WARN)
    at_commit = false
  end

  local path = resolve_path(root, sha or 'HEAD', ref.path) or ref.path
  local lnum = ref.lnum

  if at_commit then
    local content = run({ 'git', 'show', sha .. ':' .. path }, root)
    if not content then
      return
    end
    local ft = vim.filetype.match { filename = path } or ''
    open_win(win)
    scratch('gitbug://' .. sha .. '/' .. path, vim.split(content, '\n', { trimempty = false }), ft)
  else
    local new_path = path
    if sha then
      new_path = renamed_path(root, sha, path)
      local changed
      lnum, changed = follow_line(root, sha, path, new_path, lnum)
      if changed then
        vim.notify(string.format('%s:%d changed since %s, jumped to its hunk', path, ref.lnum, sha), vim.log.levels.WARN)
      end
    end
    open_win(win)
    vim.cmd.edit(vim.fn.fnameescape(root .. '/' .. new_path))
  end

  pcall(vim.api.nvim_win_set_cursor, 0, { lnum, 0 })
  vim.cmd 'normal! zz'
end

--- Closes issue `id` with a "Fixed-by:" comment naming a commit picked from the log.
---
--- @param id string git-bug issue id
--- @param root string repository root
--- @param on_done fun()? called after the issue is closed
function M.close_with_commit(id, root, on_done)
  require('fzf-lua').fzf_exec('git log --no-color --format="%h %s" -n 300', {
    prompt = 'Fixed by> ',
    cwd = root,
    preview = 'git show --stat --color=always {1}',
    actions = {
      ['default'] = function(selected)
        local short = selected[1]:match '^(%x+)'
        local commit = run({ 'git', 'log', '-1', '--format=%h %s', '--abbrev=12', short }, root)
        if not commit then
          return
        end

        local msg = 'Fixed-by: ' .. vim.trim(commit)
        if not run({ 'git', 'bug', 'bug', 'comment', 'new', id, '--non-interactive', '-m', msg }, root) then
          return
        end
        if not run({ 'git', 'bug', 'bug', 'status', 'close', id }, root) then
          return
        end

        vim.notify(string.format('Closed %s (%s)', id, msg))
        if on_done then
          on_done()
        end
      end,
    },
  })
end

--- Shows the commit named on the current "Fixed-by:" line, if any.
---
--- @return boolean # false if the line is not a "Fixed-by:" line
local function open_fixed_by()
  local sha = vim.api.nvim_get_current_line():match '^%s*Fixed%-by:%s*(%x+)'
  if not sha then
    return false
  end

  local content = run({ 'git', 'show', '--no-color', sha }, vim.b.gitbug_root)
  if content then
    scratch('gitbug://commit/' .. sha, vim.split(content, '\n'), 'git')
  end
  return true
end

--- Shows issue `id` in a scratch buffer with keymaps to open its refs.
---
--- @param id string git-bug issue id
--- @param root string? repository root, defaults to the current one
function M.show(id, root)
  root = root or git_root()
  if not root then
    vim.notify('Not in a git repository', vim.log.levels.ERROR)
    return
  end

  local content = run({ 'git', 'bug', 'bug', 'show', id }, root)
  if not content then
    return
  end

  local buf = scratch('gitbug://' .. id, vim.split(content, '\n'), 'markdown')
  vim.b[buf].gitbug_root = root

  local opts = { buffer = buf, nowait = true }

  vim.keymap.set('n', '<CR>', function()
    if not open_fixed_by() then
      open_ref(true)
    end
  end, vim.tbl_extend('force', opts, { desc = 'Open ref at pinned commit' }))

  vim.keymap.set('n', 'c', function()
    M.close_with_commit(id, root, function()
      M.show(id, root)
    end)
  end, vim.tbl_extend('force', opts, { desc = 'Close issue with a fixing commit' }))

  vim.keymap.set('n', 'gf', function()
    open_ref(true)
  end, vim.tbl_extend('force', opts, { desc = 'Open ref at pinned commit' }))

  vim.keymap.set('n', 'gF', function()
    open_ref(false)
  end, vim.tbl_extend('force', opts, { desc = 'Open ref in working tree' }))

  local keymaps = {
    { '<C-w>f', true, 'split', 'Open ref at pinned commit in split' },
    { '<C-w>F', false, 'split', 'Open ref in working tree in split' },
    { '<C-w>gf', true, 'tab', 'Open ref at pinned commit in tab' },
    { '<C-w>gF', false, 'tab', 'Open ref in working tree in tab' },
  }

  for _, m in ipairs(keymaps) do
    vim.keymap.set('n', m[1], function()
      open_ref(m[2], m[3])
    end, vim.tbl_extend('force', opts, { desc = m[4] }))
  end
  vim.keymap.set('n', 'r', function()
    M.show(id, root)
  end, vim.tbl_extend('force', opts, { desc = 'Reload issue' }))
  vim.keymap.set('n', 'q', '<cmd>bdelete<cr>', vim.tbl_extend('force', opts, { desc = 'Close issue' }))
end

--- Picker for git-bug issues.
---
--- @param opts { all: boolean? }? `all` includes closed issues
function M.pick(opts)
  opts = opts or {}
  local root = git_root()
  if not root then
    vim.notify('Not in a git repository', vim.log.levels.ERROR)
    return
  end

  local query = opts.all and {} or { 'status:open' }

  local json = run(vim.list_extend({ 'git', 'bug', 'bug', '-f', 'json' }, query), root)
  if not json then
    return
  end

  local entries = {}

  for _, bug in ipairs(vim.json.decode(json) or {}) do
    local labels = table.concat(bug.labels or {}, ',')
    local status = opts.all and (bug.status .. ' ') or ''
    table.insert(entries, string.format('%s\t%s%-10s\t%s', bug.human_id, status, labels, bug.title))
  end

  require('fzf-lua').fzf_exec(entries, {
    prompt = opts.all and 'Issues (all)> ' or 'Issues> ',
    cwd = root,
    preview = 'git bug bug show {1}',
    fzf_opts = { ['--delimiter'] = '\t', ['--with-nth'] = '1..' },
    actions = {
      ['default'] = function(selected)
        M.show(selected[1]:match '^(%x+)', root)
      end,
      ['ctrl-x'] = function(selected)
        M.close_with_commit(selected[1]:match '^(%x+)', root)
      end,
    },
  })
end

return M
