return {
  Lua = {
    runtime = { version = "LuaJIT" },
    diagnostics = {
      enable = true,
      globals = { "vim", "describe", "it", "before_each", "after_each" },
      disable = {
        "unused-local",
        "unused-vararg",
        "lowercase-global",
        "undefined-field",
      },
    },
    workspace = {
      library = vim.list_extend({ [vim.fn.expand('$VIMRUNTIME/lua')] = true }, {})
    }
  },
  completion = { callSnippet = "Both", keywordSnippet = "Both" },
}
