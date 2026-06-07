-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Neogit = require("neogit")
local Issue = require("usrcmds.issue")
local Dump = require("usrcmds.dump")

vim.api.nvim_create_user_command("Issue", function(opts)
  Issue.Issue(opts)
end, { nargs = "+" })

vim.api.nvim_create_user_command("I", function(opts)
  Issue.Issue(opts)
end, { nargs = "+" })

vim.api.nvim_create_user_command("Dump", function(opts)
  Dump.Dump(opts)
end, { nargs = "+" })

vim.api.nvim_create_user_command("D", function(opts)
  Dump.Dump(opts)
end, { nargs = "+" })

vim.keymap.set("n", "<leader>gg", function()
  Neogit.open()
end)

vim.keymap.set("n", "<leader>sd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "<leader>si", function()
  local clients = vim.lsp.get_clients()
  local get_imp_support = false

  for _, c in ipairs(clients) do
    if c.supports_method(c, "textDocument/implementation") then
      get_imp_support = true
      break
    end
  end

  if get_imp_support then
    vim.lsp.buf.implementation()
  end

  local current_word = vim.fn.expand("<cword>")
  require("telescope.builtin").live_grep({
    default_text = current_word,
  })
end, { desc = "Go to implementation" })
vim.keymap.set("n", "<leader>ss", function()
  require("telescope.builtin").live_grep()
end)
