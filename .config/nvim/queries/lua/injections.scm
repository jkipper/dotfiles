; syntax highlighting for query
(chunk 
    local_declaration: (variable_declaration
        (assignment_statement
            (variable_list
                name: (identifier) @name
                (#match? @name "ts_?.*_query")
            )
            (expression_list
              value: (string "[["
                content: (string_content) @injection.content 
                    (#set! injection.language "query")
                )
            )
        )
    )     
)
