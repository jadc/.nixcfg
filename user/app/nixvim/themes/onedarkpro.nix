{ pkgs, ... }:

{
    programs.nixvim = {
        extraPlugins = with pkgs.vimPlugins; [ onedarkpro-nvim ];
        extraConfigLua = ''
            require("onedarkpro").setup({
                colors = {
                    red = "#f3556c",
                    orange = "#dc9a5b",
                    yellow = "#ebc274",
                    green = "#81d76b",
                    cyan = "#20c3d0",
                    blue = "#5daff3",
                    purple = "#dc57e6",
                    black = "#282c34",
                    highlight = "#e2be7d",
                    comment = "#7f848e",
                }
            })
            vim.cmd.colorscheme("onedark_dark")
        '';
    };
}
