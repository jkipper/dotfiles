vim.g.lua_tree_show_icons = {
  ["git"] = 1,
  ["folders"] = 0,
  ["files"] = 0,
}
return function(use)
  use {
    "kyazdani42/nvim-tree.lua",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("nvim-tree").setup {
        reload_on_bufenter = true,
        filters = {
          custom = { ".git", ".pyc$" },
        },
        diagnostics = { enable = true },
        view = { mappings = { list = { { key = "<C-e>", action = "close" } } } },
      }
      local keymap_opts = { noremap = true, silent = true }
      vim.keymap.set("n", "<C-e>", "<cmd>NvimTreeFindFileToggle<cr>", keymap_opts)
      vim.keymap.set("n", "<leader>r", "<cmd>NvimTreeRefresh<cr>", keymap_opts)
    end,
  }
end
