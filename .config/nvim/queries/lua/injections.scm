; (function_call
;   (dot_index_expression 
;     table: (identifier) @obj (#eq? @obj "vim")
;     field: (identifier) @f (#eq? @f "cmd"))
;   (arguments 
;     (string
;       content: ("string_content") @vim)) 
; )
; (string
;   start: ("string_start") @start (#eq? @start "[[")
;   content: ("string_content") @query (#match? @query "\(.+\)")
; )

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
