local lua_tree_show_icons = {
	["git"] = 1,
	["folders"] = 0,
	["files"] = 0,
}
return function(use)
	vim.api.nvim_set_var("lua_tree_show_icons", lua_tree_show_icons)
	use({
		"kyazdani42/nvim-tree.lua",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("nvim-tree").setup({ filter = { custom = { ".git", ".pyc$" } }, diagnostics = { enable = true } })
		end,
	})
end
