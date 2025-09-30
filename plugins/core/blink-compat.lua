-- Add nvim-cmp compatibility layer for blink
return {
  'saghen/blink.compat',
  version = '*',
  opts = {
    impersonate_nvim_cmp = true,
    debug = false,
  },
}
