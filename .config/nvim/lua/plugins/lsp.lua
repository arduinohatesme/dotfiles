return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  opts = {
    diagnostics = {
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
    require("mason").setup()
    require("mason-lspconfig").setup()
    for s, o in pairs(opts.servers or {}) do
      if string.find(s, "*") then
        vim.notify("bad lsp is " .. s)
      end
      vim.lsp.config(s, o or {})
      vim.lsp.enable(s)
    end
  end,
}
