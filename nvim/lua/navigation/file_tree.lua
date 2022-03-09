vim.g.lua_tree_show_icons = {
	["git"] = 1,
	["folders"] = 0,
	["files"] = 0,
}
return function(use)
	use {
		"kyazdani42/nvim-tree.lua",
		requires = "kyazdani42/nvim-web-devicons",
		cmd = "NvimTreeToggle",
		config = function()
			require("nvim-tree").setup {
				filter = {
					custom = { ".git", ".pyc$" },
				},
				diagnostics = { enable = true },
				view = { mappings = { list = { { key = "<C-e>", action = "close" } } } },
			}
		end,
	}
end
