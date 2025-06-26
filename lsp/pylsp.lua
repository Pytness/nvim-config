return {
  cmd = { 'pylsp' },
  settings = {
    pylsp = {
      plugins = {
        pyls_black = { enabled = true },
        isort = { enabled = true },
        pycodestyle = {
          enabled = true,
          ignore = { 'E501', 'E231' },
          maxLineLength = 120,
        },
      },
    },
  },
}
