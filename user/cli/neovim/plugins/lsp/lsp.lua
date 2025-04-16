local __lspServers = {
    { name = "bashls" },
    { name = "clangd", extraOptions = { cmd = { "clangd", "--background-index", "--clang-tidy" } } },
    { name = "cmake" },
    { name = "cssls" },
    { name = "eslint" },
    { name = "gopls" },
    { name = "html" },
    { name = "lua_ls", extraOptions = { settings = { Lua = { telemetry = { enable = false } } } } },
    { name = "nixd" },
    { name = "pyright" },
    { name = "rust_analyzer" },
    { name = "svelte" },
    { name = "ts_ls", extraOptions = { filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" } } },
    { name = "yamlls" },
}

local lspOnAttach = function(client, bufnr) end
local __lspCapabilities = function()
    capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
    return capabilities
end

local __setup = {
    on_attach = lspOnAttach,
    capabilities = __lspCapabilities(),
}

for _, server in ipairs(__lspServers) do
    if type(server) == "string" then
        require("lspconfig")[server].setup(__setup)
    else
        local options = server.extraOptions

        if options == nil then
            options = __setup
        else
            options = vim.tbl_extend("keep", options, __setup)
        end

        require("lspconfig")[server.name].setup(options)
    end
end

-- Setup LSP actions dropdown menu
vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
        local opts = {buffer = event.buf}

        vim.cmd.amenu([[PopUp.Info <Cmd>lua vim.lsp.buf.hover()<CR>]])
        vim.cmd.amenu([[PopUp.Definition <Cmd>lua vim.lsp.buf.definition()<CR>]])
        vim.cmd.amenu([[PopUp.Usages <Cmd>lua vim.lsp.buf.references()<CR>]])
        vim.cmd.amenu([[PopUp.Refactor <Cmd>lua vim.lsp.buf.rename()<CR>]])
        vim.cmd.amenu([[PopUp.Error <Cmd>lua vim.diagnostic.open_float()<CR>]])
    end
})
