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

-- TODO: move to telescope/mappings.lua
local ts = require("telescope.builtin")
local mappings = {
    { key = "gd", action = ts.lsp_definitions },
    { key = "gD", action = vim.lsp.buf.declaration },
    { key = "gi", action = ts.lsp_implementations },
    { key = "gr", action = ts.lsp_references },
    { key = "gt", action = ts.lsp_type_definitions },
    { key = "ge", action = vim.diagnostic.open_float },
    { key = "gee", action = vim.diagnostic.setqflist },
    { key = "gE", action = vim.lsp.buf.code_action },
}

for _, map in ipairs(mappings) do
    vim.keymap.set("n", map.key, map.action)
end

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
