vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })

vim.opt.signcolumn = "yes"
require("gitsigns").setup({
    numhl = true,
    signcolumn = true,
})
