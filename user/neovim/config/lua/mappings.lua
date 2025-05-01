-- Set leader key
vim.g.mapleader = " "

local mappings = {
    -- Allow movement through wrapped lines
    {
        action = "gj",
        key = "j",
        mode = { "n", "x" },
        options = { noremap = true, silent = true },
    },
    {
        action = "gk",
        key = "k",
        mode = { "n", "x" },
        options = { noremap = true, silent = true },
    },
    {
        action = "g$",
        key = "$",
        mode = { "n", "x" },
        options = { noremap = true, silent = true },
    },
    {
        action = "g0",
        key = "0",
        mode = { "n", "x" },
        options = { noremap = true, silent = true },
    },

    -- Maintain selection after indent
    {
        action = "<gv",
        key = "<",
        mode = { "v" },
        options = { noremap = true, silent = true },
    },
    {
        action = ">gv",
        key = ">",
        mode = { "v" },
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
