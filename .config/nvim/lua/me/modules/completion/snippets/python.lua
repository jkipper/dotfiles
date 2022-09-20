local ls = require "luasnip"
local snippet = ls.snippet
local text = ls.text_node
local insert = ls.insert_node
local snippet_node = ls.snippet_node
local func = ls.function_node
local choice = ls.choice_node
local dynamic_node = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt

local selected_text_or_insert =
    require("me.modules.completion.snippets.helpers").selected_text_or_insert
local M = {}
M.debug_print = snippet(
    {
        trig = "!dbg",
        name = "Debug print",
        dscr = "Make the current variable a debug print",
    },
    fmt(
        'print(f"{{{var}=}}")',
        { var = dynamic_node(1, selected_text_or_insert, {}, { user_args = { "VARIABLE" } }) }
    )
)

return M
