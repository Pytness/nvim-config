return {
  cmd = "rust-analyzer",
  settings = {
    ['rust-analyzer'] = {

      checkOnSave = {
        allFeatures = true,
        command = 'clippy',
        extraArgs = {
          '--',
          '--no-deps',
        },
      },

      imports = {
        granularity = {
          group = 'module',
        },
        prefix = 'self',
      },
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true,
      },
      diagnostics = {
        disabled = { 'unresolved-prov-macro' },
        experimental = {
          enable = true,
        },
      },
      inlayHints = {
        bindingModeHints = {
          enable = false,
        },
        chainingHints = {
          enable = true,
        },
        closingBraceHints = {
          enable = true,
          minLines = 25,
        },
        closureReturnTypeHints = {
          enable = 'never',
        },
        lifetimeElisionHints = {
          enable = 'never',
          useParameterNames = false,
        },
        maxLength = 25,
        parameterHints = {
          enable = true,
        },
        reborrowHints = {
          enable = 'never',
        },
        renderColons = true,
        typeHints = {
          enable = true,
          hideClosureInitialization = false,
          hideNamedConstructor = false,
        },
      },
    },
  }
}
