return {
  'folke/snacks.nvim',
  opts = {
    lazygit = {
      configure = true,
      config = {
        os = { editPreset = 'nvim-remote' },
        gui = {
          nerdFontsVersion = '3',
        },
        promptToReturnFromSubprocess = false,
      },
    },
  },

  keys = {
    {
      '<leader>ml',
      function()
        Snacks.lazygit()
      end,
      desc = 'Open LazyGit',
    },
  },
}
