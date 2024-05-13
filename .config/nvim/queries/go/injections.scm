(short_var_declaration 
    left: (expression_list (identifier) @name (#match? @name ".*Yaml"))
    right: (expression_list (raw_string_literal) @injection.content 
        (#offset! @injection.content 0 1 0 -1) 
        (#set! injection.language "yaml")
    )
)
