-- Set leader key
vim.g.mapleader = " "

local mappings = {
    -- Allow movement through wrapped lines
    {
        key = "j",
        action = "gj",
        mode = { "n", "x" },
        options = { noremap = true, silent = true },
    },
    {
        key = "k",
        action = "gk",
        mode = { "n", "x" },
        options = { noremap = true, silent = true },
    },
    {
        key = "$",
        action = "g$",
        mode = { "n", "x" },
        options = { noremap = true, silent = true },
    },
    {
        key = "0",
        action = "g0",
        mode = { "n", "x" },
        options = { noremap = true, silent = true },
    },

    -- Maintain selection after indent
    {
        key = "<",
        action = "<gv",
        mode = { "v" },
        options = { noremap = true, silent = true },
    },
    {
        key = ">",
        action = ">gv",
        mode = { "v" },
        options = { noremap = true, silent = true },
    },

    -- Center search query to middle of buffer
    {
        key = "n",
        action = "nzzzv",
        mode = { "n" },
        options = { noremap = true, silent = true },
    },
    {
        key = "N",
        action = "Nzzzv",
        mode = { "n" },
        options = { noremap = true, silent = true },
    },
}
for _, map in ipairs(mappings) do
    vim.keymap.set(map.mode, map.key, map.action, map.options)
end

local disabled = {
    -- Disable arrow keys
    "<Up>",
    "<Down>",
    "<Left>",
    "<Right>"
}
for _, key in ipairs(disabled) do
    vim.keymap.set({ "n", "x", "i" }, key, "<Nop>", { noremap = true, silent = true })
end
