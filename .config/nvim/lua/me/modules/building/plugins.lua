local c = require "me.modules.building.config"
local export = require("me.core.pack").export_config(c)

return export {
    task_runner = { "stevearc/overseer.nvim" },
    dap = {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            { "theHamsta/nvim-dap-virtual-text" },
            { "mfussenegger/nvim-dap" },
        },
        config = function()
            require("dapui").setup {}
            -- require("nvim-dap-virtual-text").setup {}
            vim.api.nvim_create_user_command("DapUiToggle", require("dapui").toggle, {})
        end,
    },
}
