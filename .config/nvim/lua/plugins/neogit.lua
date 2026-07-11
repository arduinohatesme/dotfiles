return {
  "NeogitOrg/neogit",
  lazy = true,
  dependencies = {
    "esmuellert/codediff.nvim",
    "m00qek/baleia.nvim",
    "folke/snacks.nvim",
  },
  cmd = "Neogit",
  keys = { "<leader>gg", "<cmd>Neogit<cr>", desc = "Open Neogit" },
}
