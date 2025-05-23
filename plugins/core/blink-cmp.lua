-- Adds completion
return {
  'saghen/blink.cmp',
  lazy = false, -- lazy loading handled internally
  version = 'v0.*',
  opts = {
    completion = {
      trigger = {
        show_on_keyword = false,
        show_on_trigger_character = false,
        show_on_insert_on_trigger_character = false,
        show_on_accept_on_trigger_character = false,
      },
      menu = {
        min_width = 15,
      },

      documentation = {
        auto_show = true,
        auto_show_delay_ms = 0,
        update_delay_ms = 50,
      },
    },

    signature = { enabled = true },

    sources = {
      default = {
        'lsp',
        'path',
        'snippets',
        'buffer',
      },
    },

    fuzzy = {
      sorts = { 'score', 'kind', 'label' },
    },

    keymap = {
      preset = 'default',
      ['<C-j>'] = { 'select_next' },
      ['<C-k>'] = { 'select_prev' },
      ['<C-l>'] = { 'accept' },
      ['<C-Space>'] = { 'show' },
    },

    cmdline = {
      keymap = {
        preset = 'default',
        ['<Tab>'] = { 'show', 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next' },
        ['<C-k>'] = { 'select_prev' },
        ['<C-l>'] = { 'accept' },
        ['<C-Space>'] = { 'show' },
      },
    },

    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- will be removed in a future release
      use_nvim_cmp_as_default = true,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },
  },
  -- allows extending the providers array elsewhere in your config
  -- without having to redefine it
  opts_extend = { 'sources.default' },
}
