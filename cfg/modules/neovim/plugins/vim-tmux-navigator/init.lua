-- vim-tmux-navigator keybindings
-- Use Alt+hjkl to navigate between vim splits and tmux panes

vim.g.tmux_navigator_no_mappings = 1

vim.keymap.set("n", "<M-h>", "<Cmd>TmuxNavigateLeft<CR>", { silent = true })
vim.keymap.set("n", "<M-j>", "<Cmd>TmuxNavigateDown<CR>", { silent = true })
vim.keymap.set("n", "<M-k>", "<Cmd>TmuxNavigateUp<CR>", { silent = true })
vim.keymap.set("n", "<M-l>", "<Cmd>TmuxNavigateRight<CR>", { silent = true })

-- Resize splits with Alt+Shift+hjkl
vim.keymap.set("n", "<M-S-h>", "<Cmd>vertical resize +5<CR>", { silent = true })
vim.keymap.set("n", "<M-S-j>", "<Cmd>resize +5<CR>", { silent = true })
vim.keymap.set("n", "<M-S-k>", "<Cmd>resize -5<CR>", { silent = true })
vim.keymap.set("n", "<M-S-l>", "<Cmd>vertical resize -5<CR>", { silent = true })
