return {
  -- Add the Mofiqul/vscode.nvim plugin
  {
    "Mofiqul/vscode.nvim",
    lazy = false, -- Load this during startup
    priority = 1000, -- Ensure it loads before other plugins
    opts = {
      transparent = true,
      italic_comments = true,
      underline_links = true,
      disable_nvimtree_bg = true,
      italic_inlayhints = true,
    },
    config = function(_, opts)
      require("vscode").setup(opts)
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vscode",
    },
  },
}
