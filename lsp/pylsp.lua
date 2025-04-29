return {
  cmd = { 'pylsp' },
  settings = {
    pylsp = {
      plugins = {
        pyls_black = { enabled = true },
        isort = { enabled = true },
      },
    },
  },
}
