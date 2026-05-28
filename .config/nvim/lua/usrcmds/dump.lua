local M = {}

function M.Dump(opts)
  if #opts.fargs == 0 or pargs == nil then
    vim.notify("Not enough arguments!")
    return
  end

  local path = vim.fn.expand("~/braindump/quick/" .. pargs[1] .. ".md")
  vim.fn.mkdir(vim.fn.fnamemodify(path, ":h"), "p")

  local points = {}
  local args = opts.fargs
  for i = 2, #opts.fargs do
    local point = "* "
    table.insert(points, point)
  end

  if not vim.fn.filewritable(path) then
    vim.fn.writefile({}, path)
  end

  vim.fn.writefile(points, path, "a")
  vim.notify("Successfully wrote dump!")
end

return M
