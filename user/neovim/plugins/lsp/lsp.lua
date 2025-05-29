local __lspServers = {
    { name = "bashls" },
    { name = "clangd", opts = { cmd = { "clangd", "--background-index", "--clang-tidy" } } },
    { name = "cmake" },
    { name = "cssls" },
    { name = "eslint" },
    { name = "gopls" },
    { name = "html" },
    { name = "lua_ls", opts = {
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you"re using
                    -- (most likely LuaJIT in the case of Neovim)
                    version = "LuaJIT",
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = {
                        "vim",
                        "require"
                    },
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            },
        },
    } },
    { name = "nixd" },
    { name = "pyright" },
    { name = "rust_analyzer" },
    { name = "svelte" },
    { name = "ts_ls", opts = { filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" } } },
    { name = "yamlls" },
}

local __setup = {
    on_attach = function(_, bufnr)
        local ts = require("telescope.builtin")
        local opts = { buffer = bufnr }

        local mappings = {
            { key = "gd", action = ts.lsp_definitions,          desc = "Go to definition" },
            { key = "gD", action = vim.lsp.buf.declaration,     desc = "Go to declaration" },
            { key = "gi", action = ts.lsp_implementations,      desc = "Go to implementation" },
            { key = "gr", action = ts.lsp_references,           desc = "Find references" },
            { key = "gt", action = ts.lsp_type_definitions,     desc = "Go to type definition" },
            { key = "gK", action = vim.lsp.buf.hover,           desc = "Hover documentation" },
            { key = "ge", action = vim.diagnostic.open_float,   desc = "Show error" },
        }

        for _, map in ipairs(mappings) do
            vim.keymap.set("n", map.key, map.action, vim.tbl_extend("force", opts, { desc = map.desc }))
        end
    end,
    capabilities = vim.tbl_deep_extend("force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
    ),
}

for _, server in ipairs(__lspServers) do
    require("lspconfig")[server.name].setup(vim.tbl_deep_extend("force", __setup, server.opts or {}))
end

-- Setup styling of error virtual text
vim.diagnostic.config({
    virtual_text = false,      -- Disable in-line errors
    virtual_lines = true,      -- Enable errors on separate line
    underline = true,
    signs = true,
    update_in_insert = false,  -- Only update errors in normal mode
    severity_sort = true,      -- Show errors over warnings
})
