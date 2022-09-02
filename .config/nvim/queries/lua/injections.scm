(function_call
  (dot_index_expression 
    table: (identifier) @obj (#eq? @obj "vim")
    field: (identifier) @f (#eq? @f "cmd"))
  (arguments 
    (string
      content: ("string_content") @vim)) 
)
(string
  start: ("string_start") @start (#eq? @start "[[")
  content: ("string_content") @query (#match? @query "\(.+\)")
)
