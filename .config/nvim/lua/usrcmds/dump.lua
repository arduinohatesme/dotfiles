local ParseQuotes = require("extras.parsequotes")
local M = {}

function M.Dump(opts)
  local pargs = ParseQuotes.ParseQuotes(opts.fargs) or { {} }
  if #pargs == 0 then
    vim.notify("Invalid arguments!")
    return
  end

  local path = vim.fn.expand("~/braindump/quick/" .. pargs[1] .. ".md")
  vim.fn.mkdir(vim.fn.fnamemodify(path, ":h"), "p")

  local points = {}
  for i = 2, #pargs do
    local point = "* " .. pargs[i]
    table.insert(points, point)
  end

  if not vim.fn.filewritable(path) then
    vim.fn.writefile({}, path)
  end

  vim.fn.writefile(points, path, "a")
  vim.notify("Successfully wrote dump!")
end

return M
