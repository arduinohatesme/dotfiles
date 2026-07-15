return {
  {
    "nvim-mini/mini.surround",
    event = { "BufReadPre", "BufNewFile" },
    config = {
      custom_surroundings = {},

      highlight_duration = 2000,

      mappings = {
        add = "<localleader>sa",
        delete = "<localleader>sd",
        find = "<localleader>sf",
        find_left = "<localleader>sF",
        highlight = "<localleader>sh",
        replace = "<localleader>sr",

        suffix_last = "l",
        suffix_next = "n",
      },
    },

    search_method = "cover_or_next",
  },

  {
    "nvim-mini/mini.diff",
    event = "VeryLazy",
    opts = {
      view = {
        style = "sign",
        signs = {
          add = "▎",
          change = "▎",
          delete = "",
        },
      },
    },
  },

  {
    "nvim-mini/mini.pairs",
    event = "VeryLazy",
    opts = {
      modes = { insert = true, command = true, terminal = true },
    },
  },

  {
    "nvim-mini/mini.ai",
    version = false,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mini.ai").setup({
        -- Table with textobject id as fields, textobject specification as values.
        -- Also use this to disable builtin textobjects. See |MiniAi.config|.
        custom_textobjects = nil,

        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
          -- Main textobject prefixes
          around = "a",
          inside = "i",

          -- Next/last variants
          -- NOTE: This (deliberately) overrides Neovim>=0.12 built-in incremental
          -- selection mappings. See `:h MiniAi-default-an-in` for more details.
          around_next = "an",
          inside_next = "in",
          around_last = "al",
          inside_last = "il",

          -- Move cursor to corresponding edge of `a` textobject
          goto_left = "g[",
          goto_right = "g]",
        },

        -- Number of lines within which textobject is searched
        n_lines = 50,

        -- How to search for object (first inside current line, then inside
        -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
        -- 'cover_or_nearest', 'next', 'previous', 'nearest'.
        search_method = "cover_or_next",

        -- Whether to disable showing non-error feedback
        -- This also affects (purely informational) helper messages shown after
        -- idle time if user input is required.
        silent = false,
      })
    end,
  },
}
