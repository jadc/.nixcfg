{ pkgs, ... }:

{
    programs.neovim.plugins = with pkgs.vimPlugins; [ mini-pairs ];
    xdg.configFile."nvim/after/plugin/mini-pairs.lua".source = ./init.lua;
}
