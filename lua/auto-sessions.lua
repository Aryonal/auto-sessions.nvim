local M = {}

local default_opts = {
    auto_save = true,
    auto_load = false,
    session_folder = vim.fn.stdpath("state") .. "/sessions",
}

function M.setup(opts)
    local util = require("auto-sessions.util")

    opts = opts or {}
    opts = util.merge_tbl(default_opts, opts)

    local session_file = util.session_path(opts)
    if session_file == "" then
        return
    end

    ---set up autocmds
    local group = vim.api.nvim_create_augroup("aryonal/auto-sessions.nvim", { clear = true })
    require("auto-sessions.cmds").autosave_on_leave(opts, session_file, group)
    require("auto-sessions.cmds").autoload_on_enter(opts, session_file, group)

    ---set up commands
    require("auto-sessions.cmds").create_cmd_save(opts, session_file)
    require("auto-sessions.cmds").create_cmd_load(opts, session_file)
end

return M
