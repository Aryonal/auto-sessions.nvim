local M = {}

local default_opts = {
    auto_save = true,
    auto_load = false,
    session_folder = vim.fn.stdpath("data") .. "/sessions",
}

function M.init(otps)
    local util = require("snapshot.util")

    opts = util.merge_tbl(default_opts, opts)
    local session_file = util.session_path(opts)
    if session_file == "" then
        return
    end
    local group = vim.api.nvim_create_augroup("aryonal/snapshot.nvim", { clear = true })
    require("snapshot.cmds").autoload_on_enter(opts, session_file, group)
end

function M.setup(opts)
    local util = require("snapshot.util")

    opts = opts or {}
    opts = util.merge_tbl(default_opts, opts)

    local session_file = util.session_path(opts)
    if session_file == "" then
        return
    end

    ---set up autocmds
    local group = vim.api.nvim_create_augroup("aryonal/snapshot.nvim", { clear = true })
    require("snapshot.cmds").autosave_on_leave(opts, session_file, group)
    require("snapshot.cmds").autoload_on_enter(opts, session_file, group)

    ---set up commands
    require("snapshot.cmds").create_cmd_save(opts, session_file)
    require("snapshot.cmds").create_cmd_load(opts, session_file)
end

return M
