-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*/leet/*",

  callback = function(args)
    local bufnr = args.buf

    if vim.b[bufnr].leetcode_fixed then
      return
    end

    vim.defer_fn(function()
      if vim.api.nvim_buf_is_valid(bufnr) then
        vim.cmd("silent! normal! u")
        vim.b[bufnr].leetcode_fixed = true
      end
    end, 500)
  end,
})
