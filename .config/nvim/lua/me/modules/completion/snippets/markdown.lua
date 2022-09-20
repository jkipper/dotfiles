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

M.link = snippet(
    {
        trig = "!link",
        name = "markdown_link",
        dscr = "Create a markdown link",
    },
    fmt("[{name}]({link})", {
        name = insert(1, "NAME"),
        link = dynamic_node(2, selected_text_or_insert, {}, { user_args = { "LINK" } }),
    })
)

return M
