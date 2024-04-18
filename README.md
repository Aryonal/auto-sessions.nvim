# sessions.nvim

A toy plugin for neovim session management.

## Features

- Auto-save on exiting neovim
- Auto-load on entering neovim under certain condition

## Install

<details>
    <summary>lazy.nvim</summary>

```lua
{
    "aryonal/sessions.nvim",
    init = function()
        require("sessions").setup({
            auto_save_on_leave = true,
            auto_load_on_enter = false,
        })
    end,
}
```

_\* the `setup()` is only for minimal commands and autocmds setting, no significant harm to startup time._

</details>

## Configuration

Default options

```lua
{
    auto_save_on_leave = true,
    auto_load_on_enter = false,
    override_non_empty = false, -- whether the auto-load overrides the file/dir, e.g. `vim .` or `vim path/to/file`
    session_folder = vim.fn.stdpath("state") .. "/sessions",
    sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,terminal",
}
```

## Roadmap

- TBD

## Relevant

- [folke/persistence.nvim](https://github.com/folke/persistence.nvim)
- [rmagatti/auto-session](https://github.com/rmagatti/auto-session)
