local M = {}

function M.ParseQuotes(args)
  local in_quotes = false
  local curr = ""
  local parsed = { curr }
  local cidx = 0

  for _, arg in ipairs(args) do
    if in_quotes == false then
      cidx = cidx + 1

      if arg:sub(1, 1) == '"' then
        in_quotes = true
      end
    end

    if arg:sub(-1, -1) ~= '"' then
      in_quotes = false
    end

    table.insert(parsed, cidx, curr .. arg)
  end

  return parsed
end

return M
