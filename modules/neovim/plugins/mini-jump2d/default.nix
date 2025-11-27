{ pkgs, ... }:

{
    programs.neovim.plugins = with pkgs.vimPlugins; [ mini-jump2d ];
    xdg.configFile."nvim/after/plugin/mini-jump2d.lua".source = ./init.lua;
}
