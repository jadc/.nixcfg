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

local __setup = {
    on_attach = function(_, bufnr)
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

-- Bash
setup_server("bashls", {})

-- C/C++
setup_server("clangd", {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--limit-results=0",
        "--log=verbose"
    },
    init_options = {
        fallbackFlags = { "-std=c++11" },
    },
})

-- Go
setup_server("gopls", {})

-- Lua
setup_server("lua_ls", {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = {
                    "vim",
                    "require"
                },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
})

-- Nix
setup_server("nixd", {})

-- Python
setup_server("pyright", {})

-- Rust
setup_server("rust_analyzer", {})

-- Svelte
setup_server("svelte", {})

-- TypeScript/JavaScript
setup_server("ts_ls", {
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
    },
})

-- Web
setup_server("cssls", {})
setup_server("eslint", {})
setup_server("html", {})
setup_server("jsonls", {})

-- YAML
setup_server("yamlls", {})
