local M = {}

--- Create an enumeration from a list of names.
--- Example:
--- ```lua
--- local Color = enum({ "RED", "GREEN", "BLUE" })
--- print(Color.RED) --> 1
--- ```
--- @param tbl string[] List of names to turn into an enum
--- @return table<string, integer> enum A table mapping each name to an integer value
function M.enum(tbl)
  local e = {}
  for i, v in ipairs(tbl) do
    e[v] = i
  end
  return e
end

return M
