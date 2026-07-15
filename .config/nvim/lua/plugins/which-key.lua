return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts_extend = { "spec" },
  opts = {
    preset = "helix",
    defaults = {},

    spec = {
      {
        mode = { "n", "x" },
        { "<leader>", group = "global" },
        { "<leader>s", group = "search" },
        { "<leader>f", group = "find" },
        { "<leader>u", group = "ui" },
        { "<localleader>", group = "local" },
        { "<localleader>f", group = "find" },
        { "<localleader>m", group = "make" },
        { "<localleader>s", group = "surround" },
        { "[", group = "prev" },
        { "]", group = "next" },
        { "g", group = "goto" },
        { "-", group = "fold" },

        {
          "<leader>b",
          group = "buffer",
          expand = function()
            return require("which-key.extras").expand.buf()
          end,
        },

        {
          "<leader>w",
          group = "windows",
          proxy = "<c-w>",
          expand = function()
            return require("which-key.extras").expand.win()
          end,
        },

        -- better descriptions
        { "gx", desc = "Open with system app" },
      },
    },
  },

  keys = {
    {
      "<leader>b?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Keymaps (which-key)",
    },
  },
}
