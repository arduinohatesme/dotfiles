return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    formatters_by_ft = {
      javascript = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      json = { "prettierd", "prettier", stop_after_first = true },
      html = { "prettierd", "prettier", stop_after_first = true },
      css = { "prettierd", "prettier", stop_after_first = true },
      scss = { "prettierd", "prettier", stop_after_first = true },

      python = { "ruff_fix", "ruff_format", stop_after_first = false },
      lua = { "stylua" },
      nix = { "nixfmt" },
      cpp = { "clang-format" },
      c = { "clang-format" },
    },

    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    }
  },
}
