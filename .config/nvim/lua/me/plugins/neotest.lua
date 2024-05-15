return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-neotest/neotest-python",
        "nvim-neotest/nvim-nio",
        "nvim-neotest/neotest-go",
    },
    config = function()
        require("neotest").setup {
            adapters = {
                require "neotest-python",
                require "rustaceanvim.neotest",
                require "neotest-go",
            },
        }
    end,
}
