return {
  "monkoose/matchparen.nvim",
  event = "BufReadPost",
  config = function()
    require('matchparen').setup({
      enabled = true,
      hl_group = 'MatchParen',
      skip_folds = true,
    })
  end
}
