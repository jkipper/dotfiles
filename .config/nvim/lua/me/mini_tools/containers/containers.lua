local job = require "plenary.job"

local executable = "devcontainer"
local container_executable = "podman"
local cwd = vim.fn.getcwd()

local TermBuffer = require "me.mini_tools.containers.term_buffer"

local DevContainer = {}
DevContainer.__index = DevContainer

function DevContainer:new()
    local conf = {
        active_id = nil,
        last_job = nil,
        stdout = {},
        buf = nil,
    }
    local obj = setmetatable(conf, self)
    return obj
end

function DevContainer:start()
    self.last_job = job:new {
        command = executable,
        args = { "up", "--workspace-folder", cwd, "--docker-path", container_executable },
        on_start = function()
            self.buf = TermBuffer:new()
        end,
        on_exit = function(_, return_val)
            if return_val ~= 0 then
                self.buf:show()
            else
                self.buf:close()
            end
        end,
        on_stderr = function(_, data)
            self.buf:send(data)
        end,
        on_stdout = function(_, data)
            self.buf:send(data)
            local as_json = vim.json.decode(data)
            self.result = as_json["outcome"]
            self.active_id = as_json["containerId"]
            if self.result ~= "success" then
                vim.notify("Something went wrong during devcontainer startup" .. as_json["description"])
            end
            if self.active_id ~= nil then
                vim.notify("Started container " .. self.active_id)
            end
        end,
    }
    self.last_job:start()
    return self.last_job
end

function DevContainer:stop(delete)
    local job_running = self.last_job and self.last_job["code"] == nil
    if not job_running and not self.active_id then
        vim.notify "No container active"
        return nil
    end
    local mk_job = function()
        return job:new {
            command = container_executable,
            args = { "container", delete and "rm" or "stop", self.active_id },
            on_start = function()
                vim.notify("Stopping container " .. self.active_id)
                self.buf = TermBuffer:new()
            end,
            on_exit = function(_, return_val)
                vim.notify("Job returned with return code: " .. return_val)
                if return_val ~= 0 then
                    self.buf:show()
                end
                self.active_id = nil
            end,
            on_stderr = function(_, data)
                self.buf:send(data)
            end,
            on_stdout = function(_, data)
                self.buf:send(data)
            end,
        }
    end
    if job_running then
        self.last_job:after(function()
            mk_job():start()
        end)
    else
        self.last_job = mk_job()
        self.last_job:start()
    end
    return mk_job()
end

---Attempt to wrap a command with devcontainer (if one is active) doesn't work yet
---@param cmd table
---@return table
function DevContainer:wrap_if_active(cmd)
    if cmd then
        print("received_cmd: " .. table.concat(cmd, " "))
    end
    if self.active_id == nil then
        print "devcontainer not active, return default"
        return cmd
    end

    local new_cmd = { container_executable, "exec", "-i", self.active_id }
    vim.notify "EXECUTING"
    local exists = job:new({ command = container_executable, args = { self.active_id, "which", cmd[1] } }):sync()
    vim.list_extend(new_cmd, cmd)
    print(table.concat(new_cmd, " "))
    return new_cmd
end

function DevContainer:reload_pyright()
    require("completion.conf").init_server("pyright", function(cmd)
        return self:wrap_if_active(cmd)
    end)
end

-- Attach to container as shell. Might be stupid to do
function DevContainer:enter()
    if self.active_id ~= nil then
        vim.opt.shell = "podman exec -i -w " .. cwd .. " -e SHELL=/bin/bash -l /bin/bash"
        vim.opt.shellcmdflag = "-c"
    end
end

local container = DevContainer:new()
vim.api.nvim_create_user_command("DevcontainerDown", function()
    container:stop()
end, {})
vim.api.nvim_create_user_command("ShowOutput", function()
    container.buf:show()
end, {})
vim.api.nvim_create_user_command("DevcontainerUp", function()
    container:start()
end, {})
vim.api.nvim_create_user_command("DevcontainerEnter", function()
    container:enter()
end, {})

return container
