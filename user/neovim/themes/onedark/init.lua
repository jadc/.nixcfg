local _onedark = require("onedark")
_onedark.setup({
    style = "deep",
    colors = {
        bg0 = "#000000",
        bg1 = "#000000",
        fg  = "#dde0e5",
    },
})
_onedark.load()
vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#111111" })
