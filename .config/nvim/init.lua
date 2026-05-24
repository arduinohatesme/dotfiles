-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.opt.clipboard = "unnamedplus"

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })

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
