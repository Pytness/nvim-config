local function fzf_factory(name)
  return function()
    local fzf = require 'fzf-lua'
    return fzf[name]()
  end
end

local function search_todo()
  local todo_keywords = '(FIX|BUG|ISSUE|TODO|HACK|WARN|WARNING|XXX|NOTE|INFO|PERF|OPTIM|PERFORMANCE|OPTIMIZE|TEST):'
  local fzf = require 'fzf-lua'

  fzf.grep {
    header = false,
    prompt = 'Todo> ',
    search = todo_keywords,
    no_esc = true,
  }
end

return {
  { 'n', '<leader>sh', fzf_factory 'help_tags', { desc = 'Search help tags' } },
  { 'n', '<leader>sk', fzf_factory 'keymaps', { desc = 'Search keymaps' } },
  { 'n', '<leader>sf', fzf_factory 'files', { desc = 'Search files' } },
  { 'n', '<leader>ss', fzf_factory 'builtin', { desc = 'Search fzf builtin commands' } },
  { 'n', '<leader>sg', fzf_factory 'live_grep', { desc = 'Live grep' } },
  { 'n', '<leader>sw', fzf_factory 'grep_cword', { desc = 'Search word under cursor' } },
  { 'n', '<leader>sW', fzf_factory 'grep_cWORD', { desc = 'Search WORD under cursor' } },
  { 'n', '<leader>sv', fzf_factory 'grep_visual', { desc = 'Search visual selection' } },
  { 'n', '<leader>sd', fzf_factory 'diagnostics_document', { desc = 'Search diagnostics' } },
  { 'n', '<leader>sD', fzf_factory 'diagnostics_workspace', { desc = 'Search diagnostics in workspace' } },
  { 'n', '<leader>so', fzf_factory 'oldfiles', { desc = 'Search oldfiles' } },
  { 'n', '<leader>s.', fzf_factory 'resume', { desc = 'Resume search' } },
  { 'n', '<leader>s/', fzf_factory 'lines', { desc = 'Search in open buffers' } },
  { 'n', '<leader>sL', fzf_factory 'lsp_document_symbols', { desc = 'LSP symbols in document' } },
  { 'n', '<leader>sl', fzf_factory 'lsp_workspace_symbols', { desc = 'LSP symbols in workspace' } },
  { 'n', '<leader>sm', fzf_factory 'marks', { desc = 'LSP symbols in document' } },
  { 'n', '<leader>st', search_todo, { desc = 'Search todo' } },
}
