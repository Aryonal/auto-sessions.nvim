---@diagnostic disable: unused-local
local M = {}

---create session save command
---@param opts any
---@param session_file any
function M.create_cmd_save(opts, session_file)
    vim.api.nvim_create_user_command(
        "SaveLocalSession",
        function()
            vim.cmd(string.format("source %s", session_file))
        end,
        { desc = "Save local session" })
end

---create session load command
---@param opts any
---@param session_file any
function M.create_cmd_load(opts, session_file)
    vim.api.nvim_create_user_command(
        "LoadLocalSession",
        function()
            if vim.fn.filereadable(session_file) ~= 1 then
                vim.notify("Session file not exists: " .. session_file)
                return
            end

            vim.cmd(string.format("source %s", session_file))
            vim.notify("Loading " .. session_file)
        end,
        { desc = "Load local session" })
end

---register autocmds for autosave on leave
---@param opts table: option table
---@param session_file string: session file path
---@param group any: autocmd group
function M.autosave_on_leave(opts, session_file, group)
    if not opts.auto_save then
        return
    end
    -- TODO: check group is nil
    vim.api.nvim_create_autocmd({ "VimLeave" }, {
        group = group,
        desc = "Save session on leave",
        callback = function()
            vim.cmd(string.format("mksession! %s", session_file))
        end,
    })
end

function M.autoload_on_enter(opts, session_file, group)
    if not opts.auto_load then
        return
    end
    vim.api.nvim_create_autocmd({ "VimEnter" }, {
        group = group,
        desc = "Load session on enter",
        nested = true,
        callback = function()
            if vim.fn.filereadable(session_file) ~= 1 then
                vim.notify("Session file not exists: " .. session_file)
                return
            end

            vim.cmd(string.format("source %s", session_file))
            vim.notify("Loading " .. session_file)
        end,
    })
end

return M
