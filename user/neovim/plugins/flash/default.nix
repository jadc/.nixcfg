{ pkgs, ... }:

{
    programs.neovim.plugins = with pkgs.vimPlugins; [ flash-nvim ];
    xdg.configFile."nvim/after/plugin/flash.lua".source = ./init.lua;
}
