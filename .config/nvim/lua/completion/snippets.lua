local ls = require("luasnip")
local snippet = ls.snippet
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamic_node = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt

local selected_text_or_insert = function(_, snip, _, default_text) if snip.env.TM_SELECTED_TEXT[1] then
    return snippet("nil",
      { text(snip.env.TM_SELECTED_TEXT[1])
      })
  else
    return snippet("nil", { insert(1, default_text) })
  end
end


local python_debug_print = snippet({
  trig = "!dbg",
  name = "Debug print",
  dscr = "Make the current variable a debug print",
},
  fmt('print(f"{{{var}=}}")',
    { var = dynamic_node(1, selected_text_or_insert, {}, { user_args = { "VARIABLE" } }) }))

local markdown_link = snippet({
  trig = "!link",
  name = "markdown_link",
  dscr = "Create a markdown link"
}, fmt("[{name}]({link})", {
  name = insert(1, "NAME"),
  link = dynamic_node(2, selected_text_or_insert, {}, { user_args = { "LINK" } }) }))

local snippets = {
  python = { python_debug_print },
  markdown = { markdown_link }
}

local function init()
  for file_type, snip in pairs(snippets) do
    ls.add_snippets(file_type, snip)
  end
  ls.config.set_config({
    store_selection_keys = "<C-S>"
  })
end

return { init = init }
