{ pkgs, ... }:

{
    programs.neovim.plugins = with pkgs.vimPlugins; [ lualine-nvim ];
    xdg.configFile."nvim/after/plugin/lualine.lua".source = ./init.lua;
}
