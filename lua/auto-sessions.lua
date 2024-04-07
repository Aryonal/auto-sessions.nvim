local M = {}

local default_opts = {
    auto_save_on_leave = true,
    auto_load_on_enter = false,
    override_non_empty = false,
    session_folder = vim.fn.stdpath("state") .. "/sessions",
    sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,terminal",
}

function M.setup(opts)
    local util = require("auto-sessions.util")

    opts = opts or {}
    opts = util.merge_tbl(default_opts, opts)

    ---set up autocmds
    local group = vim.api.nvim_create_augroup("aryonal/auto-sessions.nvim", { clear = true })
    require("auto-sessions.cmds").autosave_on_leave(opts, group)
    require("auto-sessions.cmds").autoload_on_enter(opts, group)

    ---set up commands
    require("auto-sessions.cmds").create_cmd_save(opts)
    require("auto-sessions.cmds").create_cmd_load(opts)

    vim.o.sessionoptions = opts.sessionoptions
end

return M
