local ts_lua_query = [[
(call 
    function: (attribute 
        attribute: (identifier) @func_name)
    arguments: (argument_list . (string)+ @content 
        (#match? @cont "f\".*\"")
    )
)]]

local ts_py_query = "(call)"
