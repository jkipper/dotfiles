
; Module docstring
(module . (expression_statement (string (string_content) @injection.content
                                (#set! injection.language "rst"))))

; Class docstring
(class_definition
  body: (block . (expression_statement (string (string_content) @injection.content (#set! injection.language "rst")  ))))

; Function/method docstring
(function_definition
  body: (block . (expression_statement (string (string_content) @injection.content (#set! injection.language "rst")))))

; Attribute docstring
((expression_statement (assignment)) . (expression_statement (string (string_content) @injection.content (#set! injection.language "rst"))))
