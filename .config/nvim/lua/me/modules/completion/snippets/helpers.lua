local ls = require "luasnip"
local snippet = ls.snippet
local text = ls.text_node
local insert = ls.insert_node
local snippet_node = ls.snippet_node
local func = ls.function_node
local choice = ls.choice_node
local dynamic_node = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local M = {}
M.selected_text_or_insert = function(_, snip, _, default_text)
    if snip.env.TM_SELECTED_TEXT[1] then
        return snippet_node(nil, { text(snip.env.TM_SELECTED_TEXT[1]) })
    else
        return snippet_node(nil, { insert(1, default_text) })
    end
end

return M
