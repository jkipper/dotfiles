require("luasnip.session.snippet_collection").clear_snippets "go"

local ls = require "luasnip"

local s = ls.snippet
local txt = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local fn = ls.function_node
local dyn = ls.dynamic_node
local sn = ls.sn
local fmta = require("luasnip.extras.fmt").fmta
local postfix = require("luasnip.extras.postfix").postfix

local defaults = {
    int = function() return txt "0" end,
    bool = function() return txt "false" end,
    string = function() return txt '""' end,
    error = function(info)
        print(vim.inspect(info))
        if info then
            info.index = info.index + 1
            return c(info.index, {
                txt(string.format('fmt.Errorf("%s: %%v", %s)', info.func_name, info.err_name)),
                txt(info.err_name),
                txt(string.format('fmt.Errorf("%s: %%w", %s)', info.func_name, info.err_name)),
                txt(string.format('errors.Wrap(%s, "%s")', info.err_name, info.func_name)),
            })
        else
            return txt "err"
        end
    end,
}

local transform = function(text, info)
    local out = defaults[text]
    if out ~= nil then
        return out(info)
    elseif text:find("*", 1, true) then
        return txt "nil"
    end
    return txt(text)
end

local handlers = {
    parameter_list = function(node, info)
        local result = {}
        local count = node:named_child_count()
        for idx = 0, count - 1 do
            table.insert(
                result,
                transform(vim.treesitter.get_node_text(node:named_child(idx), 0), info)
            )
            if idx ~= count - 1 then
                table.insert(result, txt { ", " })
            end
        end

        return result
    end,

    type_identifier = function(node, info)
        local text = vim.treesitter.get_node_text(node, 0)
        return { transform(text, info) }
    end,
}

---@class ResultInfo
---@field index number
---@field err_name string
---@field func_name string

---Get the result type of the function
---@param info ResultInfo
---@return any[]
local function go_result_type(info)
    local starting_node_types = {
        function_declaration = true,
        method_declaration = true,
        func_literal = true,
    }

    local node = vim.treesitter.get_node()
    while node ~= nil do
        if starting_node_types[node:type()] then
            break
        end
        node = node:parent()
    end

    if not node then
        vim.notify "not inside a function"
        return { txt "" }
    end
    -- query is defined in after/ftplugin/go.lua to avoid load before ts parsing
    local query = vim.treesitter.query.get("go", "Luasnip_Result")
    if query == nil then
        vim.notify "Failed to load query"
        return { txt "" }
    end
    for _, capture in query:iter_captures(node, 0) do
        if handlers[capture:type()] then
            return handlers[capture:type()](capture, info)
        end
    end

    return { txt "nil" }
end

---@param func_call string
local postfix_err_text = function(func_call)
    return function()
        return sn(
            nil,
            go_result_type {
                index = 0,
                err_name = "err",
                func_name = func_call:match "([%w%d%._]+)%(.*%)",
            }
        )
    end
end

-- choice node for the error format
-- requires the initial insert node for selection

local iferr_postfix = postfix({ trig = ".siferr!", match_pattern = "[%w%d%._]+%(.*%)" }, {
    dyn(
        1,
        function(_, parent)
            return sn(
                nil,
                fmta(
                    [[
if err := <call>; err != nil {
    return <err_out>
} 
                    ]],
                    {
                        call = txt(parent.env.POSTFIX_MATCH),
                        err_out = dyn(1, postfix_err_text(parent.env.POSTFIX_MATCH)),
                    }
                )
            )
        end
    ),
})

local var_err_postfix = postfix({ trig = ".svarerr!", match_pattern = "[%w%d%._]+%(.*%)" }, {
    dyn(
        1,
        function(_, parent)
            return sn(
                nil,
                fmta(
                    [[
<val>, err := <call>
if err != nil {
    return <err_out>
}
            ]],
                    {
                        val = i(1, { "val" }),
                        call = txt(parent.env.POSTFIX_MATCH),
                        err_out = dyn(2, postfix_err_text(parent.env.POSTFIX_MATCH)),
                    }
                )
            )
        end
    ),
})

ls.add_snippets("go", { iferr_postfix, var_err_postfix })
