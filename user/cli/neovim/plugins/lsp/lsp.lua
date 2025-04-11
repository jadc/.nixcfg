require("lsp_lines").setup()

local __lspServers = {
    {
        extraOptions = {
            filetypes = {
                "javascript",
                "javascriptreact",
                "javascript.jsx",
                "typescript",
                "typescriptreact",
                "typescript.tsx",
            },
        },
        name = "ts_ls",
    },
    { name = "svelte" },
    { name = "rust_analyzer" },
    { name = "pyright" },
    { extraOptions = { cmd = { "OmniSharp" } }, name = "omnisharp" },
    { name = "nixd" },
    { extraOptions = { settings = { Lua = { telemetry = { enable = false } } } }, name = "lua_ls" },
    { name = "jsonls" },
    { name = "html" },
    { name = "gopls" },
    { name = "eslint" },
    { name = "cssls" },
    { name = "cmake" },
    { extraOptions = { cmd = { "clangd", "--background-index", "--clang-tidy" } }, name = "clangd" },
    { name = "bashls" },
}
-- Adding lspOnAttach function to nixvim module lua table so other plugins can hook into it.
_M.lspOnAttach = function(client, bufnr) end
local __lspCapabilities = function()
    capabilities = vim.lsp.protocol.make_client_capabilities()

    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

    return capabilities
end

local __setup = {
    on_attach = _M.lspOnAttach,
    capabilities = __lspCapabilities(),
}

for i, server in ipairs(__lspServers) do
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

local __nixvim_autogroups = { nixvim_binds_LspAttach = { clear = true } }

for group_name, options in pairs(__nixvim_autogroups) do
    vim.api.nvim_create_augroup(group_name, options)
end

local __nixvim_autocommands = {
    {
        callback = function(args)
            do
                local __nixvim_binds = {}

                for i, map in ipairs(__nixvim_binds) do
                    local options = vim.tbl_extend("keep", map.options or {}, { buffer = args.buf })
                    vim.keymap.set(map.mode, map.key, map.action, options)
                end
            end
        end,
        desc = "Load keymaps for LspAttach",
        event = "LspAttach",
        group = "nixvim_binds_LspAttach",
    },
}

for _, autocmd in ipairs(__nixvim_autocommands) do
    vim.api.nvim_create_autocmd(autocmd.event, {
        group = autocmd.group,
        pattern = autocmd.pattern,
        buffer = autocmd.buffer,
        desc = autocmd.desc,
        callback = autocmd.callback,
        command = autocmd.command,
        once = autocmd.once,
        nested = autocmd.nested,
    })
end
