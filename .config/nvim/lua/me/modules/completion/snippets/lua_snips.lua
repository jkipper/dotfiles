local ls = require "luasnip"

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fn = ls.function_node
local dyn = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt

local M = {}
M.req = s(
    {
        trig = "!req",
        name = "local require",
    },
    fmt('local {name} = require "{module}"', {
        module = i(1),
        name = fn(function(args, snip)
            local line = vim.split(args[1][1], ".", true)
            return line[#line]
        end, { 1 }),
    })
)

return M
