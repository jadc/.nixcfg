-- Options
local opts = {
    --- Disable backups
    backup = false,
    swapfile = false,
    undofile = false,
    writebackup = false,

    --- Tabs, Wrapping, and Spacing
    breakindent = true,  -- Maintain indent when wrapping
    colorcolumn = "80",  -- Column width marker
    expandtab = true,    -- Tabs as spaces
    linebreak = true,    -- Don't cut words while wrapping
    shiftwidth = 4,
    softtabstop = 4,
    tabstop = 4,         -- Tab size

    --- Visibility
    cmdheight = 0,   -- Hide command line
    --laststatus = 0,  -- Hide status line
    number = true,   -- Show line numbers

    --- Folding
    foldlevel = 20,

    --- Search
    hlsearch = true,    -- Enables search highlight
    ignorecase = true,  -- Case insensitive search
    smartcase = true,   -- Sensitive if search has caps

    --- Miscellaneous
    clipboard = "unnamedplus",  -- Use system clipboard
}

for k, v in pairs(opts) do
    vim.opt[k] = v
end

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Disable right-click menu
vim.cmd.aunmenu("PopUp")
