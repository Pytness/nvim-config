local ensure_installed = { 'bash', 'c', 'html', 'jsonc', 'lua', 'markdown', 'vim', 'vimdoc' }

local function is_parser_available(parser)
  local available = require('nvim-treesitter').get_available()

  for _, lang in ipairs(available) do
    if lang == parser then
      return true
    end
  end

  return false
end

--- @async
--- Install the parser for the given filetype if it's not already installed
---
--- @param language string | nil
local function install_missing_language(language)
  if not is_parser_available(language) then
    return nil
  end

  return require('nvim-treesitter').install(language)
end

-- Highlight, edit, and navigate code
return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main', -- Master branch is deprecated
  build = ':TSUpdate',
  lazy = false,
  opts = {
    install_dir = vim.fn.stdpath 'data' .. '/site',
  },
  config = function()
    require('nvim-treesitter').install { ensure_installed }

    -- Make nvim stfu about dock- wah wah wah
    vim.treesitter.language.register('dockerfile', 'Dockerfile')

    vim.api.nvim_create_autocmd('FileType', {
      pattern = { '*' },
      callback = function(context)
        local bufnr = context.buf

        local filetype = context.match
        local language = vim.treesitter.language.get_lang(filetype)

        local task = install_missing_language(language)

        if task == nil then
          return
        end

        task:await(function()
          if vim.treesitter.language.add(language) then
            vim.treesitter.start(bufnr, language)

            local winid = vim.fn.bufwinid(bufnr)

            vim.wo[winid].foldmethod = 'expr'
            vim.wo[winid].foldexpr = 'v:lua.vim.treesitter.foldexpr()' -- Use treesitter for folds
            vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end)
      end,
    })
  end,
}
