return {
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      italic_comments = true,
      underline_links = true,
      disable_nvimtree_bg = true,
      italic_inlayhints = true,
    },
    config = function(_, opts)
      local vsc = require("vscode")
      vsc.setup(opts)
      local colors = require("vscode.colors").get_colors()
      vim.cmd.colorscheme("vscode")
      vim.api.nvim_set_hl(0, "MiniDiffSignAdd", { fg = colors.vscGitAdded, bg = "NONE" })
      vim.api.nvim_set_hl(0, "MiniDiffSignChange", { fg = colors.vscGitModified, bg = "NONE" })
      vim.api.nvim_set_hl(0, "MiniDiffSignDelete", { fg = colors.vscGitDeleted, bg = "NONE" })
    end,
  },
}
