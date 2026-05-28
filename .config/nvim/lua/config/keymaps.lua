-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Neogit = require("neogit")
local Issue = require("usrcmds.issue")
local Dump = require("usrcmds.dump")

vim.api.nvim_create_user_command("Issue", function(opts)
  Issue.Issue(opts)
end, { nargs = "+" })

vim.api.nvim_create_user_command("Dump", function(opts)
  Dump.Dump(opts)
end, { nargs = "+" })

vim.keymap.set("n", "<leader>gg", function()
  Neogit.open()
end)
