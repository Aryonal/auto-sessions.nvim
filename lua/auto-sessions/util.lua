local M = {}

-- strip_path will remove the leading and trailing slashes, and dots
-- Example:
--  /home/user/.config/nvim -> home/user/.config/nvim
--  ./home/user/.config/nvim -> home/user/.config/nvim
---@param path string: file path to strip
local function strip_path(path)
    path = string.gsub(path, "^/*", "") -- Remove leading slashes
    path = string.gsub(path, "/*$", "") -- Remove trailing slashes
    path = string.gsub(path, "^%.", "") -- Remove leading dots
    return path
end

---path_as_filename will replace slashes with dots
---it's used in scenarios where we want to use the path as a filename
---@param path string: full path to convert
local function path_as_filename(path)
    path = strip_path(path)
    return string.gsub(path, "/", ".") -- Replace slashes with dots
end

---get session file path
---@param opts table: option table
---@return string: file path
function M.session_path(opts)
    local session_folder = opts.session_folder or opts.session_folder or vim.fn.stdpath("state") .. "/sessions"
    vim.fn.mkdir(session_folder, "p")
    if vim.fn.isdirectory(session_folder) ~= 1 then
        vim.notify("[Auto Sessions] Failed to create session folder: " .. session_folder)
        return ""
    end

    ---session file name reflects working dir
    local cw = vim.fn.getcwd()
    cw = strip_path(cw)
    local session_file = session_folder .. "/" .. path_as_filename(cw) .. ".vim"

    return session_file
end

---Merge two tables into one.
---If elements in a and b share the same key, value from b will overwrite value from a.
---@param a table: the first table to merge.
---@param b table: the second table to merge.
---@return table: the merged table.
function M.merge_tbl(a, b)
    if type(a) ~= "table" or type(b) ~= "table" then
        return {}
    end

    local m = {}
    for k, v in pairs(a) do
        m[k] = v
    end
    for k, v in pairs(b) do
        m[k] = v
    end

    return m
end

return M
