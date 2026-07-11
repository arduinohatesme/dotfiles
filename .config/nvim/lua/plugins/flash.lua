return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    labels = "jfkdlshag",

    search = {
      multi_window = false,
      mode = "fuzzy",
      max_length = false,
    },

    jump = {
      history = true,
      register = false,
      autojump = true,
    },

    label = {
      uppercase = true,
      reuse = "lowercase",
    },

    modes = {
      char = {
        label = { exclude = "qwertyuiopzxcvbnm" },
        keys = { "f", "F", "t", "T", ";", "," },

        search = { wrap = false },
        highlight = { backdrop = true },
        jump = {
          register = true,
          autojump = true,
        },
      },

      treesitter = {
        labels = "jfkdlshag",
        jump = { pos = "range", autojump = true },
      },

      treesitter_search = {
        jump = { pos = "range" },
        search = { multi_window = false, wrap = true, incremental = false },
        label = { before = true, after = true, style = "inline" },
      },
    },

    prompt = {
      prefix = { { "󱐋", "FlashPromptIcon" } },
    },
  },
  keys = {
    {
      "s",
      mode = "n",
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },

    {
      "S",
      mode = "n",
      function()
        require("flash").treesitter()
      end,
      desc = "Flash Treesitter",
    },
  },
}
