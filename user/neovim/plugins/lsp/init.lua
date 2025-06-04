-- Setup styling of error virtual text
vim.diagnostic.config({
    virtual_text = false,      -- Disable in-line errors
    virtual_lines = true,      -- Enable errors on separate line
    underline = true,
    signs = true,
    update_in_insert = false,  -- Only update errors in normal mode
    severity_sort = true,      -- Show errors over warnings
})

local ts = require("telescope.builtin")
local __setup = {
    on_attach = function(_, bufnr)
        local mappings = {
            { key = "gd", action = ts.lsp_definitions },
            { key = "gD", action = vim.lsp.buf.declaration },
            { key = "gi", action = ts.lsp_implementations },
            { key = "gr", action = ts.lsp_references },
            { key = "gt", action = ts.lsp_type_definitions },
            { key = "gK", action = function() vim.lsp.buf.hover { border = "rounded" } end },
            { key = "ge", action = vim.diagnostic.open_float },
        }

        for _, map in ipairs(mappings) do
            vim.keymap.set("n", map.key, map.action, { buffer = bufnr })
        end
    end,
    capabilities = vim.tbl_deep_extend("force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
    ),
}

local setup_server = function(name, opts)
    vim.lsp.config(name, vim.tbl_deep_extend("force", __setup, opts or {}))
    vim.lsp.enable(name)
end
