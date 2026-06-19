return {
  "neovim/nvim-lspconfig",
  event = "VeryLazy",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  opts = {
    diagnostics = {
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        source = "always",
        prefix = "●",
      },
      severity_sort = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = require("config.icons").diagnostics.Error,
          [vim.diagnostic.severity.WARN] = require("config.icons").diagnostics.Warn,
          [vim.diagnostic.severity.INFO] = require("config.icons").diagnostics.Info,
          [vim.diagnostic.severity.HINT] = require("config.icons").diagnostics.Hint,
        },
      },
    },
    inlay_hints = {
      enabled = true,
    },
    codelens = {
      enabled = false,
    },
    folds = {
      enabled = true,
    },
    format = {
      formatting_options = nil,
      timeout_ms = nil,
    },
  },
  config = function(_, opts)
    vim.diagnostic.config(opts.diagnostics)
    require("mason").setup()
    require("mason-lspconfig").setup()
    for s, o in pairs(opts.servers or {}) do
      if s ~= "*" then
        vim.lsp.config(s, o or {})
        vim.lsp.enable(s)
      end
    end
  end,
}
