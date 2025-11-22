return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  version = false, -- set this if you want to always pull the latest change
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = 'make',
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    --- The below dependencies are optional,
    'stevearc/dressing.nvim',
    'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
    'zbirenbaum/copilot.lua', -- for providers='copilot'
  },
  opts = {
    provider = 'copilot',
    providers = {
      copilot = {
        model = 'gpt-4.1',
        extra_request_body = {},
        auto_select_model = false,
        use_response_api = true,
      },
    },
    behaviour = {
      auto_suggestions = false, -- Experimental stage any opts here
      enable_fastapply = false,
    },
    selection = {
      enabled = false,
    },
    -- file_selector = {
    --   provider = 'fzf',
    --   provider_opts = {},
    -- },
    windows = {
      spinner = {
        generating = { '   ', '.  ', '.. ', '...' },
      },
      edit = {
        border = 'rounded',
      },

      ask = {
        border = 'rounded',
      },
    },
  },
}
