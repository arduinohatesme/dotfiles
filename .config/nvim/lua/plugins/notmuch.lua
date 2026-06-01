return {
  "yousefakbar/notmuch.nvim",
  cmd = { "Notmuch", "Config" },
  config = function()
    vim.keymap.set("n", "<leader>mr", "<CMD>Notmuch<CR>")
    vim.keymap.set("n", "<leader>mw", "<CMD>Compose<CR>")
    local opts = {
      maildir_sync_cmd = "gmi sync",
      open_cmd = "xdg-open",
      logfile = nil,
      sync = {
        sync_mode = "background", -- "background" | "buffer" | "terminal"
      },
      suppress_deprecation_warning = false, -- Used for API deprecation warning suppression
      render_html_body = true, -- True means prioritize displaying rendered HTML
      open_handler = function(attachment)
        require("notmuch.handlers").default_open_handler(attachment)
      end,
      view_handler = function(attachment)
        return require("notmuch.handlers").default_view_handler(attachment)
      end,
      keymaps = { -- This should capture all notmuch.nvim related keymappings
        sendmail = "<C-s>",
        attachment_window = "<C-a>",
      },
    }
    require("notmuch").setup(opts)
  end,
}
