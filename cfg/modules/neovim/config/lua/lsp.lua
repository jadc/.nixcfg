-- Sensible default LSP configs
vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })

-- Setup styling of error virtual text
vim.diagnostic.config({
    virtual_text = false,      -- Disable in-line errors
    virtual_lines = true,      -- Enable errors on separate line
    underline = true,
    signs = true,
    update_in_insert = false,  -- Only update errors in normal mode
    severity_sort = true,      -- Show errors over warnings
})

-- Disable logging to ~/.local/state/nvim/lsp.log
vim.lsp.log.set_level("off")

-- Customize hover window appearance
vim.opt.winborder = "rounded"

vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "ge", vim.diagnostic.open_float)
vim.keymap.set("n", "gee", vim.diagnostic.setqflist)
vim.keymap.set("n", "gE", vim.lsp.buf.code_action)

-- Enable language servers
vim.lsp.enable({
    "bashls",
    "clangd",
    "cssls",
    "eslint",
    "gopls",
    "html",
    "jsonls",
    "lua_ls",
    "nixd",
    "pyright",
    "rust_analyzer",
    "svelte",
    "ts_ls",
    "yamlls",
})
