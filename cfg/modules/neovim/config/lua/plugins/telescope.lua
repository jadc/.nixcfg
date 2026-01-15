vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons",
})

require("nvim-web-devicons").setup({})

require("telescope").setup({
    defaults = {
        border = true,
        layout_strategy = "vertical",
        sorting_strategy = "ascending",
        layout_config = {
            vertical = {
                height = 0.999,
                width = 0.999,
                prompt_position = "top",
            },
        },
    },
    pickers = {
        buffers = {
            mappings = {
                i = { ["<c-w>"] = "delete_buffer" },
                n = { ["<c-w>"] = "delete_buffer" },
            },
        },
    },
})

local ts = require("telescope.builtin")
local is_inside_work_tree = {}
_G.project_files = function()
    local cwd = vim.fn.getcwd()
    if is_inside_work_tree[cwd] == nil then
        vim.fn.system("git rev-parse --is-inside-work-tree")
        is_inside_work_tree[cwd] = vim.v.shell_error == 0
    end
    if is_inside_work_tree[cwd] then
        ts.git_files()
    else
        ts.find_files()
    end
end

-- Color telescope UI borders
local border_hl = { fg = "#404040", bg = "#000000" }
for _, group in ipairs({ "TelescopeBorder", "TelescopePromptBorder", "TelescopeResultsBorder", "TelescopePreviewBorder" }) do
    vim.api.nvim_set_hl(0, group, border_hl)
end

vim.keymap.set({ "n", "x" }, "<c-f>", "<cmd>Telescope live_grep<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "<c-p>", "<cmd>lua project_files()<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "<c-P>", ts.find_files, { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "<c-t>", ts.buffers, { noremap = true, silent = true })
