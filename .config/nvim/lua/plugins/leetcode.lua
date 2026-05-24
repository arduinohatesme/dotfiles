return {
  "kawre/leetcode.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },

  opts = {
    lang = "python3",

    storage = {
      home = vim.fn.expand("~/leet/"),
      cache = vim.fn.stdpath("cache") .. "/leetcode",
    },

    template = {
      question = {
        setup = {
          set_last_submission = false,
        },
      },
    },

    restore = {
      stats = false,
      solutions = false,
    },

    logging = false,
    image_support = false,
  },
}
