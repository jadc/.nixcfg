vim.pack.add({ "https://github.com/echasnovski/mini.jump2d" })

require("mini.jump2d").setup({
    view = {
        dim = true,
    },

    allowed_lines = {
        cursor_at = false,
    },
})
