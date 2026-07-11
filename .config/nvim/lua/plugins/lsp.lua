return {
  "neovim/nvim-lspconfig",
  event = "VeryLazy",
  dependencies = {
    "williamboman/mason.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  opts = {
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

    servers = {
      gitlab_duo = {
        enabled = false,
      },
      basedpyright = {},
      clangd = {},
      eslint = {},
      ruff = {},
      ts_ls = {},
      yamlls = {},
    },
  },

  config = function(_, opts)
    vim.diagnostic.config({
      underline = true,
      update_in_insert = false,
      severity_sort = true,

      virtual_text = {
        spacing = 4,
        source = "always",
        prefix = "●",
      },

      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = require("config.icons").opts.diagnostics.Error,
          [vim.diagnostic.severity.WARN] = require("config.icons").opts.diagnostics.Warn,
          [vim.diagnostic.severity.INFO] = require("config.icons").opts.diagnostics.Info,
          [vim.diagnostic.severity.HINT] = require("config.icons").opts.diagnostics.Hint,
        },
      },
    })

    vim.lsp.config("gitlab_duo", { enabled = false })
    require("mason-tool-installer").setup({
      ensure_installed = {
        "actionlint",
        "basedpyright",
        "clangd",
        "clang-format",
        "eslint",
        "eslint_d",
        "nixfmt",
        "prettier",
        "prettierd",
        "ruff",
        "stylua",
        "ts_ls",
        "yamlls",
      },

      auto_update = true,
      run_on_start = true,
    })
    require("mason").setup()

    if opts.servers then
      opts.servers.gitlab_duo = nil
    end

    for s, o in pairs(opts.servers or {}) do
      if s ~= "*" then
        if s == "gitlab_duo" then
          o = o or {}
          o.enabled = false
        else
          vim.lsp.config(s, o or {})
          vim.lsp.enable(s)
        end
      end
    end
  end,
}
