-- https://luaunit.readthedocs.io/en/latest/
local luaunit = require("luaunit")
local t = require("lua.tables")

TestTable = {}

function TestTable:test_merge_settings() 
    -- If a value is set in first_table, it shall be in merged_table
    local first_value = { opt = "test" }
    local second_value = {}

    local merged_value = t.merge_settings(first_value, second_value)

    luaunit.assertEquals(merged_value['opt'], first_value['opt'])
    
    -- If a value is set in second_table, it shall be in merged_table
    local first_value = {}
    local second_value = { opt = "test" }

    local merged_value = t.merge_settings(first_value, second_value)

    luaunit.assertEquals(merged_value['opt'], second_value['opt'])

    -- If a value is set in first_table and in second_table, the second_table value shall be in
    -- merged_table
    local first_value = { opt = "foo" }
    local second_value = { opt = "bar" }

    local merged_value = t.merge_settings(first_value, second_value)

    luaunit.assertEquals(merged_value['opt'], second_value['opt'])
end

function TestTable:test_is_equal_table() 
    -- If values are not equal, it returns false
    local first_value = { opt = "test" }
    local second_value = {}

    local ret = t.is_equal_tables(first_value, second_value)

    luaunit.assertEquals(ret, false)

    local first_value = {}
    local second_value = { opt = "test" }

    local ret = t.is_equal_tables(first_value, second_value)

    luaunit.assertEquals(ret, false)

    -- If values are equal, it returns true
    local first_value = { opt = "test" }
    local second_value = { opt = "test" }

    local ret = t.is_equal_tables(first_value, second_value)

    luaunit.assertEquals(ret, true)
end

function TestTable:test_deep_copy() 
    local first_value = { opt = "test" }
    local expected_result = { opt = "test" }
    local ret = t.deep_copy(first_value)
    first_value = { opt = "foo"}

    luaunit.assertEquals(ret, expected_result)
end

-- run the tests
os.exit(luaunit.LuaUnit.run())
