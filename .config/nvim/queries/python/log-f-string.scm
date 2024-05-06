(call 
    function: (attribute 
        attribute: (identifier) @func_name)
    arguments: (argument_list . (string)+ @cont
        (#match? @cont "f\".*\"")
    )
)
