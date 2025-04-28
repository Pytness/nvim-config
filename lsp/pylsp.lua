return {
  cmd = { 'pylsp' },
  settings = {
    meow = "asdf",
    pylsp = {
      plugins = {
        pyls_black = { enabled = true },
        isort = { enabled = true },
      },
    },
  },
}
