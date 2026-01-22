vim.pack.add({ "https://github.com/christoomey/vim-tmux-navigator" })

-- Disable default mappings
vim.g.tmux_navigator_no_mappings = 1

-- Window navigation with Alt+hjkl
vim.keymap.set("n", "<A-h>", "<cmd>TmuxNavigateLeft<CR>", { noremap = true, silent = true, desc = "Navigate left" })
vim.keymap.set("n", "<A-j>", "<cmd>TmuxNavigateDown<CR>", { noremap = true, silent = true, desc = "Navigate down" })
vim.keymap.set("n", "<A-k>", "<cmd>TmuxNavigateUp<CR>", { noremap = true, silent = true, desc = "Navigate up" })
vim.keymap.set("n", "<A-l>", "<cmd>TmuxNavigateRight<CR>", { noremap = true, silent = true, desc = "Navigate right" })

-- Window resizing with Alt+Shift+hjkl (matches tmux resize-pane bindings)
vim.keymap.set("n", "<A-S-h>", "<cmd>vertical resize -5<CR>", { noremap = true, silent = true, desc = "Resize left" })
vim.keymap.set("n", "<A-S-j>", "<cmd>resize -5<CR>", { noremap = true, silent = true, desc = "Resize down" })
vim.keymap.set("n", "<A-S-k>", "<cmd>resize +5<CR>", { noremap = true, silent = true, desc = "Resize up" })
vim.keymap.set("n", "<A-S-l>", "<cmd>vertical resize +5<CR>", { noremap = true, silent = true, desc = "Resize right" })
