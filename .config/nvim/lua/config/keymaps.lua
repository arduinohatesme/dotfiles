-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Neogit = require("neogit")
local Snacks = require("snacks")

vim.api.nvim_create_user_command("Issue", function(opts)
  if not Snacks.git.get_root() then
    vim.notify("Not in git repo!")
    return
  end
  if not opts.fargs[1] then
    vim.notify("Must provide title!")
    return
  end
  local cmd = { "gh", "issue", "create", "--body", '""', "--title" }
  local title = {}
  local label_start = 1
  for i = 1, #opts.fargs do
    if opts.fargs[i] == "l" then
      label_start = i + 1
      break
    end
    table.insert(title, opts.fargs[i])
  end
  table.insert(cmd, table.concat(title, " "))
  for i = label_start, #opts.fargs do
    table.insert(cmd, "--label")
    table.insert(cmd, opts.fargs[i])
  end
  vim.system(cmd, function(out)
    if out.code == 0 then
      vim.notify('Issue created with title "' .. table.concat(title, " ") .. '"')
    end
  end)
end, { nargs = "+" })

vim.keymap.set("n", "<leader>gg", function()
  Neogit.open()
end)
