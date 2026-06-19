-- bootstrap lazy.nvim and your plugins
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
require("config.lazy")
require("config.options")
require("config.keymaps")
require("config.autocmds")
vim.opt.clipboard = "unnamedplus"
