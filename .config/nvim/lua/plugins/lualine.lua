local setup = function()
  require("lualine").setup({
    options = {
      icons_enabled = true,
      theme = "vscode",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      ignore_focus = {},
      always_divide_middle = true,
      always_show_tabline = true,
      globalstatus = true,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
        refresh_time = 16, -- ~60fps
        events = {
          "WinEnter",
          "BufEnter",
          "BufWritePost",
          "SessionLoadPost",
          "FileChangedShellPost",
          "VimResized",
          "Filetype",
          "CursorMoved",
          "CursorMovedI",
          "ModeChanged",
        },
      },
      disabled_filetypes = {
        statusline = {
          "snacks_dashboard",
          "snacks_picker",
          "snacks_picker_input",
          "snacks_picker_list",
          "lazy",
          "mason",
          "checkhealth",
        },
      },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = { "filename" },
      lualine_x = { "filetype" },
      lualine_y = { "progress", "location" },
      lualine_z = { { "datetime", style = "%H:%M:%S" } },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = { "filename" },
      lualine_c = {
        { "diff", source = function ()
        local summary = vim.b.minidiff_summary
        return summary and {
          added = summary.add,
          modified = summary.change,
          removed = summary.delete,
        }
      end }
    },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {},
  })

  local base_statusline_highlights =
    { "StatusLine", "StatusLineNC", "Tabline", "TabLineFill", "TabLineSel", "Winbar", "WinbarNC" }
  for _, hl_group in pairs(base_statusline_highlights) do
    vim.api.nvim_set_hl(0, hl_group, { bg = "none" })
  end
end

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = setup,
}
