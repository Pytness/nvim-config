return {
  cmd = { 'pylsp' },
  settings = {
    pylsp = {
      plugins = {
        pyls_black = { enabled = true },
        isort = { enabled = true },
        flake8 = { enabled = false },
        mccabe = { enabled = false },
        pycodestyle = {
          enabled = true,
          ignore = {
            'E501',
            'E231',
            -- Recommended by Black
            'E203',
            'E701',
            'E704',
            'W503',
          },
          maxLineLength = 120,
        },
      },
    },
  },
}
