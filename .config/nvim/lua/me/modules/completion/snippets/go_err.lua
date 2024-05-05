require("luasnip.session.snippet_collection").clear_snippets "go"

local ls = require "luasnip"

local s = ls.snippet
local txt = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local fn = ls.function_node
local dyn = ls.dynamic_node
local snippet_from_nodes = ls.sn

local ts_go_query = [[
(method_declaration result: (_) @type)
 (function_declaration result: (_) @type)
 (func_literal result: (_) @type)
]]

vim.treesitter.query.set("go", "Luasnip_Result", ts_go_query)

local function same(index)
    return fn(function(args) return args[1] end, { index })
end

local transform = function(text, info)
    print("RECEIVED INFO " .. text)
    if text == "int" then
        return txt "0"
    elseif text == "error" then
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
    elseif text == "bool" then
        return txt "false"
    elseif text == "string" then
        return txt '""'
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

local function go_result_type(info)
    local function_node_types = {
        function_declaration = true,
        method_declaration = true,
        func_literal = true,
    }

    local node = vim.treesitter.get_node()
    while node ~= nil do
        if function_node_types[node:type()] then
            break
        end
        node = node:parent()
    end

    if not node then
        vim.notify "not inside a function"
        return txt ""
    end
    local query = vim.treesitter.query.get("go", "Luasnip_Result")
    if query == nil then
        print("INVALID QUERy")
        return { txt "nil" }
    end
    for _, capture in query:iter_captures(node, 0) do
        if handlers[capture:type()] then
            return handlers[capture:type()](capture, info)
        end
    end

    return { txt "nil" }
end

local go_ret_vals = function(args)
    return snippet_from_nodes(
        nil,
        go_result_type {
            index = 0,
            err_name = args[1][1],
            func_name = args[2][1],
        }
    )
end
local smart_err = s({ trig = "!smart_err", name = "Smart error" }, {
    i(1, { "val" }),
    txt ", ",
    i(2, { "err" }),
    txt " := ",
    i(3, { "f" }),
    txt "(",
    i(4),
    txt ")",
    txt { "", "if " },
    same(2),
    txt { " != nil {", "\treturn " },
    dyn(5, go_ret_vals, { 2, 3 }),
    txt { "", "}" },
    i(0),
})
ls.add_snippets("go", { smart_err })
