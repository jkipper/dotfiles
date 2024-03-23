local c = require "me.modules.building.config"
local export = require("me.core.pack").export_config(c)

return export {
    dap = {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            { "theHamsta/nvim-dap-virtual-text" },
            { "mfussenegger/nvim-dap" },
            { "nvim-neotest/nvim-nio" },
        },
        config = function()
            require("dapui").setup {}
            -- require("nvim-dap-virtual-text").setup {}
            vim.api.nvim_create_user_command("DapUiToggle", require("dapui").toggle, {})
        end,
    },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-neotest/neotest-python",
            { "nvim-neotest/nvim-nio" },
        },
        config = function() require("neotest").setup { adapters = { require "neotest-python" } } end,
    },
}
