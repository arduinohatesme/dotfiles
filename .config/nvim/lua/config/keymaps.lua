-- Keymaps are automatically loaded on the VeryLazy event
-- Add any additional keymaps here
local Issue = require("usrcmds.issue")
local Dump = require("usrcmds.dump")

local map = vim.keymap.set
local git_group = vim.api.nvim_create_augroup("GitKeys", { clear = true })

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

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  group = git_group,
  callback = function(args)
    vim.fn.system("git rev-parse --is-inside-work-tree")

    if vim.v.shell_error == 0 then
      map("n", "<leader>g", function()
        require("neogit").open()
      end, { desc = "Open Neogit" })
    end
  end,
})

function on_empty_line()
  if vim.fn.getline("."):match("^%s*$") then
    return true
  end
  return false
end

-- i/a behave like cc on blank lines
map("n", "i", function()
  if on_empty_line() then
    return '"_cc'
  else
    return "i"
  end
end, { expr = true })

map("n", "a", function()
  if on_empty_line() then
    return '"_cc'
  else
    return "a"
  end
end, { expr = true })

-- Don't copy empty lines
map("n", "dd", function()
  if on_empty_line() then
    return '"_dd'
  else
    return "dd"
  end
end, { expr = true })

map("n", "cc", function()
  if on_empty_line() then
    return '"_cc'
  else
    return "cc"
  end
end, { expr = true })

-- x doesn't copy, use dl intentionally to copy
-- Just avoids single char copying accidentally
map("n", "x", '"_x')

-- Search for implementation with fallback
function get_impl()
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
end

-- Search (<leader>s)
map("n", "<leader>sd", vim.lsp.buf.definition, { desc = "Search for definition" })
map("n", "<leader>si", get_impl, { desc = "Search for implementations" })
map("n", "<leader>sf", function()
  require("telescope.builtin").find_files()
end, { desc = "Search filenames" })
map("n", "<leader>sl", function()
  require("telescope.builtin").live_grep()
end, { desc = "Search live" })

-- Code (local leader)
map("n", "<localleader>d", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "<localleader>s", vim.lsp.buf.rename, { desc = "Symbol Name" })
map("n", "<localleader>a", vim.lsp.buf.code_action, { desc = "Code Action" })
map("n", "<localleader>i", get_impl, { desc = "Find Implementations" })

map({ "n", "x" }, "<localleader>f", function()
  require("conform").format({ force = true })
end, { desc = "Code Format" })

map("n", "<localleader>g", "<CMD>DogeGenerate<CR>", { desc = "Generate Annotations" })

-- Make empty space for a new block
map("n", "<localleader>b", function()
  if on_empty_line() then
    return 'O<Esc>o<Esc>"_cc'
  else
    return 'o<Esc>O<Esc>o<Esc>"_cc'
  end
end, { expr = true, desc = "Code Block" })

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map(
  { "n", "x" },
  "<Down>",
  "v:count == 0 ? 'gj' : 'j'",
  { desc = "Down", expr = true, silent = true }
)
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> <shift> hjkl
map("n", "<C-S-k>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-S-j>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-S-l>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-S-h>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Saner <C-d> and <C-u>
map({ "n", "x" }, "<C-d>", "<C-d>zz")
map({ "n", "x" }, "<C-u>", "<C-u>zz")

-- buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bd", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })
map("n", "<leader>bo", function()
  Snacks.bufdelete.other()
end, { desc = "Delete Other Buffers" })
map("n", "<leader>bi", function()
  Snacks.bufdelete.invisible()
end, { desc = "Delete Invisible Buffers" })
map("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

-- Clear search and stop snippet on escape
map({ "i", "n", "s" }, "<esc>", function()
  vim.cmd("noh")
  vim.snippet.stop()
  return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- better indenting
map("x", "<", "<gv")
map("x", ">", ">gv")

-- commenting
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- diagnostic
local diagnostic_goto = function(next, severity)
  return function()
    vim.diagnostic.jump({
      count = (next and 1 or -1) * vim.v.count1,
      severity = severity and vim.diagnostic.severity[severity] or nil,
      float = true,
    })
  end
end
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- toggle options
Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
Snacks.toggle.diagnostics():map("<leader>ud")
Snacks.toggle.line_number():map("<leader>ul")
Snacks.toggle
  .option(
    "conceallevel",
    { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" }
  )
  :map("<leader>uc")
Snacks.toggle
  .option(
    "showtabline",
    { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline" }
  )
  :map("<leader>uA")
Snacks.toggle.treesitter():map("<leader>uT")
Snacks.toggle
  .option("background", { off = "light", on = "dark", name = "Dark Background" })
  :map("<leader>ub")
Snacks.toggle.dim():map("<leader>uD")
Snacks.toggle.animate():map("<leader>ua")
Snacks.toggle.indent():map("<leader>ug")
Snacks.toggle.scroll():map("<leader>uS")

if vim.lsp.inlay_hint then
  Snacks.toggle.inlay_hints():map("<leader>uh")
end
