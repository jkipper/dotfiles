local job = require "plenary.job"
local executable = "devcontainer"
local container_executable = vim.loop.os_uname().sysname == "Darwin" and "docker" or "podman"

local TermBuffer = require "me.mini_tools.containers.term_buffer"

local DevContainer = {}
DevContainer.__index = DevContainer

function DevContainer:new()
    local conf = {
        active_id = nil,
        buf = nil,
    }
    local obj = setmetatable(conf, self)
    return obj
end

function DevContainer:_job_runner(opts)
    return job:new {
        command = opts.command,
        args = opts.args,
        cwd = vim.loop.cwd(),
        on_start = vim.schedule_wrap(function()
            self.buf = TermBuffer:new()
        end),
        on_exit = function(_, return_val)
            if return_val ~= 0 then
                self.buf:show()
            else
                if opts.on_success then
                    opts.on_success()
                end
                self.buf:close()
            end
        end,
        on_stderr = function(_, data)
            self.buf:send(data)
        end,
        on_stdout = function(_, data)
            self.buf:send(data)
            if opts.on_stdout then
                opts.on_stdout(_, data)
            end
        end,
    }
end

function DevContainer:up()
    local startup_job = self:_job_runner {
        command = executable,
        args = { "up", "--workspace-folder=.", "--docker-path", container_executable },
        on_stdout = function(_, data)
            local as_json = vim.json.decode(data)
            local result = as_json["outcome"]
            local created_id = as_json["containerId"]
            if result ~= "success" then
                vim.notify("Someting with wrong during container start: " .. as_json["description"], 4)
            end
            if created_id then
                vim.notify("Started container with id: " .. created_id)
            end
        end,
    }
    startup_job:start()
    return startup_job
end

function DevContainer:stop()
    self.active_id = self:_get_active()
    if not self.active_id then
        vim.notify "No active container"
        return
    end
    local stop_job = self:_job_runner {
        command = container_executable,
        args = { "container", "stop", self.active_id },
        on_success = function()
            vim.notify("Stopped container " .. self.active_id)
        end,
    }
    stop_job:start()
    return stop_job
end

function DevContainer:delete(active_id)
    self.active_id = active_id or self.active_id

    local delete_job = self:_job_runner {
        command = container_executable,
        args = { "container", "rm", self.active_id },
        on_success = function()
            vim.notify("Deleted container " .. self.active_id)
        end,
    }
    delete_job:start()
    return delete_job
end

function DevContainer:_get_active()
    local active = job:new({
        command = container_executable,
        args = {
            "container",
            "ls",
            "-a",
            "--filter=label=devcontainer.local_folder=" .. vim.loop.cwd(),
            "--format={{.ID}}",
        },
    }):sync()
    return active[1]
end

function DevContainer:down()
    self:stop():after_success(function()
        self:delete()
    end)
end

function DevContainer:rebuild()
    local active = self.active_id or self:_get_active()
    if active then
        self:stop():after_success(function()
            local del = self:delete(self.active_id)
            del:after_success(function()
                self:up()
            end)
        end)
    else
        self:up()
    end
end

function DevContainer:_make_command_wrapper()
    local active = self:_get_active()
    if not active then
        vim.notify("Creating command requires active container", 4)
    end
    return {container_executable, "exec", "-w", vim.loop.cwd(), "bash", "-c"}
end

local container = DevContainer:new()
local register = vim.tbl_filter(function(key)
    return not vim.startswith(key, "_") and key ~= "new"
end, vim.tbl_keys(getmetatable(container)))

vim.api.nvim_create_user_command("Devcontainer", function(opt)
    container[opt.args](container)
end, {
    nargs = 1,
    complete = function()
        return register
    end,
})

return container
