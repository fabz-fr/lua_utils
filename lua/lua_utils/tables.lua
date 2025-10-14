
local M = {}

--- copy a table and return another table containing the same values
--- @param orig table to copy
--- @return table containing the data copied
function M.deep_copy(orig)
  local copy
  if type(orig) == 'table' then
    copy = {}
    for k, v in next, orig, nil do
      copy[M.deep_copy(k)] = M.deep_copy(v)
    end
    setmetatable(copy, M.deep_copy(getmetatable(orig)))
  else
    copy = orig
  end
  return copy
end

--- Check value of two tables
--- @param t1 first table 
--- @param t2 second table
--- @return true if both tables are equal, false otherwise
function M.is_equal_tables(t1, t2)
  if t1 == t2 then return true end
  if type(t1) ~= "table" or type(t2) ~= "table" then return false end

  for k, v in pairs(t1) do
    if type(v) == "table" and type(t2[k]) == "table" then
      if not tables_equal(v, t2[k]) then return false end
    elseif v ~= t2[k] then
      return false
    end
  end

  for k in pairs(t2) do
    if t1[k] == nil then return false end
  end

  return true
end

--- Merge settings from one table into another
--- @param default_opts table that is filled with user settings
--- @param user_opts table that is used to fill default_opts with custom values
--- @return table containing the merged values
function M.merge_settings(default_opts, user_opts)
    -- Start with a copy of default options
    local merged = M.deep_copy(default_opts)

    -- Override with user-provided options
    if type(user_opts) == table then
        for key, value in ipairs(user_opts) do
            merged[key] = value
        end
    end

    return merged
end

return M
