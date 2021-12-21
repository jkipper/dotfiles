local doge_mapping = "<Leader>md"
local doge_doc_standard_python = "google"

return function(use)
	vim.api.nvim_set_var("doge_mapping", doge_mapping)
	vim.api.nvim_set_var("doge_doc_standard_python", doge_doc_standard_python)
	use {
		"kkoomen/vim-doge",
		run = function()
			vim.fn["doge#install"]()
		end,
		cmd = "DogeGenerate",
	}
end
