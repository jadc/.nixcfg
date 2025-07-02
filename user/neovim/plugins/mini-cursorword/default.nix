{ pkgs, ... }:

{
    programs.neovim.plugins = with pkgs.vimPlugins; [ mini-cursorword ];
    xdg.configFile."nvim/after/plugin/mini-cursorword.lua".source = ./init.lua;
}
