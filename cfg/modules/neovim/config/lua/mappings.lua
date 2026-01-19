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

    -- Buffer navigation
    {
        key = "<Tab>",
        action = "<cmd>bnext<CR>",
        mode = { "n" },
        options = { noremap = true, silent = true, desc = "Next buffer" },
    },
    {
        key = "<S-Tab>",
        action = "<cmd>bprevious<CR>",
        mode = { "n" },
        options = { noremap = true, silent = true, desc = "Previous buffer" },
    },
    {
        key = "<leader><leader>",
        action = "<C-^>",
        mode = { "n" },
        options = { noremap = true, silent = true, desc = "Alternate buffer" },
    },

    -- Buffer management
    {
        key = "<c-w>",
        action = "<cmd>bdelete<CR>",
        mode = { "n" },
        options = { noremap = true, silent = true, nowait = true, desc = "Close buffer" },
    },
    {
        key = "<c-x>",
        action = "<cmd>silent! %bdelete|edit#|silent! bdelete#<CR>",
        mode = { "n" },
        options = { noremap = true, silent = true, nowait = true, desc = "Close other buffers" },
    },
}

-- Numeric buffer jumps (<leader>1-9)
for i = 1, 9 do
    vim.keymap.set("n", "<leader>" .. i, "<cmd>LualineBuffersJump! " .. i .. "<CR>",
        { noremap = true, silent = true, desc = "Go to buffer " .. i })
end

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
