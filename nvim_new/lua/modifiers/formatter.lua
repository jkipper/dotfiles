return function(use)
	vim.api.nvim_set_var("neoformat_enabled_python", { "black", "isort" })
	use { "sbdchd/neoformat", cmd = "Neoformat" }
end
