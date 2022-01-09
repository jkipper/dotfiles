local g = vim.g
g.doge_mapping = "<Leader>md"
g.doge_doc_standard_python = "google"

return function(use)
	use {
		"kkoomen/vim-doge",
		run = function()
			vim.fn["doge#install"]()
		end,
		cmd = "DogeGenerate",
	}
end
