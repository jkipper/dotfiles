return function(use)
	vim.g.neoformat_enabled_python = { "black", "isort" }
	use { "sbdchd/neoformat", cmd = "Neoformat" }
end
