return {
  "neovim/nvim-lspconfig",
  event = "VeryLazy",
  dependencies = {
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
      basedpyright = {
        enabled = false,
        {
          analysis = {
            autoImportCompletions = false,
            diagnosticMode = "openFilesOnly",
            maxResults = 300,
            typeCheckingMode = "strict",
          },
          capabilities = {
            textDocument = {
              completion = nil,
            },
          },
        },
      },
      clangd = {},
      eslint = {},
      ruff = {
        {
          cmd_env = { RUFF_TRACE = "messages" },
          init_options = {
            settings = {
              logLevel = "error",
            },
          },
          capabilities = { hoverProvider = false },
        },
      },
      rust_analyzer = {},
      ts_ls = {},
      ty = {},
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
    vim.lsp.enable("gitlab_duo", false)
    require("lspconfig").gitlab_duo = nil

    if opts.servers then
      opts.servers.gitlab_duo = nil
    end

    for s, o in pairs(opts.servers or {}) do
      if s ~= "*" then
        opts = o or {}
        if opts.enabled ~= false then
          if not vim.tbl_isempty(opts) then
            vim.lsp.config(s, opts)
          end
          vim.lsp.enable(s)
        end
      end
    end
  end,
}
