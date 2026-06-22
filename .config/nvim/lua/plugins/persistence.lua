vim.api.nvim_create_autocmd("User", {
  pattern = "PersistenceSavePre",
  callback = function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_is_valid(win) then
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.bo[buf].filetype == "snacks_picker_list" then
          vim.api.nvim_win_close(win, true)
        end
      end
    end
  end
  }
)

return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {},
}
