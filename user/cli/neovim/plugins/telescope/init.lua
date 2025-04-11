require("telescope").setup({})

local is_inside_work_tree = {}
_G.project_files = function()
    local opts = {}
    local cwd = vim.fn.getcwd()
    if is_inside_work_tree[cwd] == nil then
        vim.fn.system("git rev-parse --is-inside-work-tree")
        is_inside_work_tree[cwd] = vim.v.shell_error == 0
    end
    if is_inside_work_tree[cwd] then
        require("telescope.builtin").git_files(opts)
    else
        require("telescope.builtin").find_files(opts)
    end
end

vim.keymap.set({ "n", "x" }, "<c-f>", "<cmd>Telescope live_grep<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "<c-p>", "<cmd>lua project_files()<cr>", { noremap = true, silent = true })
