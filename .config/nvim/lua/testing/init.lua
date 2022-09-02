local g = vim.g

return function(use)
	g["test#strategy"] = "floaterm"
	g["test#python#runner"] = "pytest"
	-- use {
	-- 	"vim-test/vim-test",
	-- }
end
