{ pkgs, ... }:

{
    programs.neovim.plugins = with pkgs.vimPlugins; [ oil-nvim ];
    xdg.configFile."nvim/after/plugin/oil.lua".source = ./init.lua;
}
