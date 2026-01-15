vim.pack.add({ "https://github.com/romgrk/barbar.nvim" })

require("barbar").setup({})

local mappings = {
    { key = "<c-s-l>", action = "<cmd>BufferMoveNext<cr>"     },
    { key = "<c-s-h>", action = "<cmd>BufferMovePrevious<cr>" },
    { key = "<c-l>",   action = "<cmd>BufferNext<cr>"         },
    { key = "<c-t>",   action = "<cmd>BufferPick<cr>"         },
    { key = "<c-h>",   action = "<cmd>BufferPrevious<cr>"     },
    { key = "<c-s-t>", action = "<cmd>BufferRestore<cr>"      },
    { key = "<c-w>",   action = "<cmd>BufferClose<cr>"        },
}

for _, map in ipairs(mappings) do
    vim.keymap.set({ "n", "x" }, map.key, map.action, { noremap = true, silent = true, nowait = true })
end
