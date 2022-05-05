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
	},
	completion = { callSnippet = "Both", keywordSnippet = "Both" },
}
