-- Options
local opts = {
    -- Tab size
    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,
    -- Tabs as spaces
    expandtab = true,
    -- Maintain indent when wrapping
    breakindent = true,
    -- Don't cut words while wrapping
    linebreak = true,
    -- shiftround = true,
    -- copyindent = true,

    -- Folding
    foldlevel = 20,
    foldexpr = "nvim_treesitter#foldexpr()",
    foldmethod = "expr",

    -- Disable backups
    backup = false,
    writebackup = false,
    undofile = false,
    swapfile = false,

    -- Line numbers
    number = true,
    -- Case insensitive search
    ignorecase = true,
    -- Sensitive if search has caps
    smartcase = true,
    -- Removes search highlight
    hlsearch = false,
    -- Use system clipboard
    clipboard = "unnamedplus",

    -- Hide command line
    cmdheight = 0,
    -- Hide status line
    laststatus = 0,
}

for k, v in pairs(opts) do
    vim.opt[k] = v
end

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Disable right-click menu
vim.cmd.aunmenu("PopUp")

-- Highlight trailing whitespace
vim.fn.matchadd("ExtraWhitespace", "\\s\\+$")
vim.api.nvim_set_hl(0, "ExtraWhitespace", { bg = "grey" })
