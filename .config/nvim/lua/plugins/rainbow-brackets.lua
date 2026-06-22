return {
  "hiphish/rainbow-delimiters.nvim",
  config = function()
    require('rainbow-delimiters.setup').setup({
      strategy = {
          [''] = 'rainbow-delimiters.strategy.global',
          vim = 'rainbow-delimiters.strategy.local',
      },
      query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
      },
      priority = {
          [''] = 110,
          lua = 210,
      },
      highlight = {
          'RainbowDelimiterBlue',
          'RainbowDelimiterViolet',
          'RainbowDelimiterYellow',
      },
    })
    vim.api.nvim_set_hl(0, 'RainbowDelimiterBlue', { fg = "#569CD6"})
    vim.api.nvim_set_hl(0, 'RainbowDelimiterViolet', { fg = "#b576c0"})
    vim.api.nvim_set_hl(0, 'RainbowDelimiterYellow', { fg = "#caca55"})
  end,
}
