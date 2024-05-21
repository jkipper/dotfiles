(short_var_declaration 
    left: (expression_list (identifier))
    right: (expression_list (raw_string_literal) @injection.content 
        (#match? @injection.content "^(`\n)?[a-zA-Z0-9_:\-]+:\n")
        (#offset! @injection.content 0 1 0 -1) 
        (#set! injection.language "yaml")
    )
)

(var_declaration 
  (var_spec 
    name:  (identifier)
    type: (type_identifier) 
    value: (expression_list (raw_string_literal) @injection.content 
        (#match? @injection.content "^(`\n)?[a-zA-Z0-9_:\-]+:\n")
        (#offset! @injection.content 0 1 0 -1) 
        (#set! injection.language "yaml")
    )
))
