{ pkgs, ... }:

{
    programs.neovim.plugins = with pkgs.vimPlugins; [ rainbow-delimiters-nvim indent-blankline-nvim ];
    xdg.configFile."nvim/after/plugin/rainbow.lua".source = ./init.lua;
}
