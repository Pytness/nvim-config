local fzf = require 'fzf-lua'
local utils = require 'utils'

local function toggle_hints()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end

local function next_diagnostic()
  vim.diagnostic.jump { count = -1, float = true }
end

local function prev_diagnostic()
  vim.diagnostic.jump { count = 1, float = true }
end

--- Hover using 'BufLeave' to handle jumping to the definition
local function hover()
  vim.lsp.buf.hover {
    close_events = { 'CursorMoved', 'CursorMovedI', 'InsertCharPre', 'BufLeave' },
  }
end

local function jump_to_definition()
  -- utils.close_hover()
  vim.lsp.buf.definition()
end

return {
  -- Diagnostic keymaps
  { 'n', '<leader>f', 'za', { desc = 'Toggle Fold' } },
  { 'n', '<leader>lk', next_diagnostic, { desc = 'Go to previous [D]iagnostic message' } },
  { 'n', '<leader>lj', prev_diagnostic, { desc = 'Go to next [D]iagnostic message' } },
  { 'n', '<leader>lK', vim.diagnostic.reset, { desc = 'Clear all diagnostics' } },

  { 'n', '<leader>le', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' } },
  { 'n', '<leader>lq', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' } },
  { 'n', '<leader>lR', fzf.lsp_references, { desc = 'Show references' } },
  { 'n', '<leader>gi', fzf.lsp_implementations, { desc = 'Show implementations' } },

  { 'n', '<leader>lC', '<cmd>Copilot toggle<cr>', { desc = '[R]eferences' } },

  -- Rename the variable under your cursor
  --  Most Language Servers support renaming across files, etc.
  { 'n', '<leader>lr', vim.lsp.buf.rename, { desc = '[R]ename' } },

  -- Execute a code action, usually your cursor needs to be on top of an error
  -- or a suggestion from your LSP for this to activate.
  { 'n', '<leader>la', vim.lsp.buf.code_action, { desc = '[C]ode [A]ction' } },

  -- Opens a popup that displays documentation about the word under your cursor
  { 'n', 'K', hover, { desc = 'Hover Documentation' } },

  { 'n', '<leader>ld', vim.lsp.buf.declaration, { desc = '[G]oto [d]eclaration' } },
  { 'n', '<leader>lD', vim.lsp.buf.definition, { desc = '[G]oto [D]efinition' } },
  { 'n', '<leader>lt', vim.lsp.buf.type_definition, { desc = 'Type definition' } },
  { 'n', '<leader>lh', toggle_hints, { desc = 'Show inlay [H]ints' } },

  { 'n', '<C-]', jump_to_definition, { noremap = true } },
}
