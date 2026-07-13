vim.opt.runtimepath:prepend("~/.config/nvim")
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
require("config.options")
require("config.lazy")
require("config.keymaps")
require("config.autocmds")
vim.opt.clipboard = "unnamedplus"
