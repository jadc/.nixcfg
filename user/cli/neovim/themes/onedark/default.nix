{ pkgs, ... }:

{
    programs.neovim.plugins = with pkgs.vimPlugins; [ onedark-nvim ];
    xdg.configFile."nvim/after/plugin/onedark.lua".source = ./init.lua;
}
