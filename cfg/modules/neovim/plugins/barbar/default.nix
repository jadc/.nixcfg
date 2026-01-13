{ pkgs, ... }:

{
    programs.neovim.plugins = with pkgs.vimPlugins; [ barbar-nvim ];
    xdg.configFile."nvim/after/plugin/barbar.lua".source = ./init.lua;
}
