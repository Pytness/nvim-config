return {
  cmd = { 'lua-language-server' },
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {
          'vim',
          'require',
        },
      },
      workspace = {
        checkThirdParty = false,
        -- Tells lua_ls where to find all the Lua files that you have loaded
        -- for your neovim configuration.
        library = {
          '${3rd}/luv/library',
          unpack(vim.api.nvim_get_runtime_file('', true)),
        },
        -- If lua_ls is really slow on your computer, you can try this instead:
        -- library = { vim.env.VIMRUNTIME },
      },
      completion = {
        callSnippet = 'Replace',
      },
      hint = { enable = true },
      -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
      -- diagnostics = { disable = { 'missing-fields' } },
    },
  },
}
