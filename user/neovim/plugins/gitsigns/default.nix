{ pkgs, ... }:

{
    programs.neovim.plugins = with pkgs.vimPlugins; [ gitsigns-nvim ];
    xdg.configFile."nvim/after/plugin/gitsigns.lua".source = ./init.lua;
}
