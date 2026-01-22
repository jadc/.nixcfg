vim.pack.add({ "https://github.com/mcauley-penney/visual-whitespace.nvim" })

require("visual-whitespace").setup({
    match = {
      trail = true,
    },
})

-- Highlight trailing whitespace
vim.opt.list = true
vim.opt.listchars:append({ trail = "·" })

-- Highlight whitespace-only lines
vim.api.nvim_set_hl(0, "WhitespaceOnlyLine", { link = "Visual" })
vim.fn.matchadd("WhitespaceOnlyLine", "^\\s\\+$")
