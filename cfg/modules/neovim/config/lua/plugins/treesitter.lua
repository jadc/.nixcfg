vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        -- Run only when a parser exists
        if vim.treesitter.get_parser(0, vim.bo.filetype, { error = false }) then
            -- Highlighting
            vim.treesitter.start()
            -- Indentation
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            -- Folding
            vim.wo.foldmethod = "expr"
            vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        end
    end,
})
