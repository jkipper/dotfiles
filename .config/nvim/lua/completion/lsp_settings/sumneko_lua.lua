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
      library = vim.api.nvim_get_runtime_file("", true)
    }
	},
	completion = { callSnippet = "Both", keywordSnippet = "Both" },
}
