return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    formatters_by_ft = {
      javascript = { "prettier" },
      typescript = { "prettier" },
      json = { "prettier" },
      python = { "ruff" },
      html = { "prettier" },
      lua = { "prettier" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    }
  },
}
