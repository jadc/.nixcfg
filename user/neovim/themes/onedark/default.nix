{ pkgs, ... }:

{
    programs.neovim.plugins = with pkgs.vimPlugins; [ onedark-nvim ];
    xdg.configFile."nvim/lua/theme.lua".source = ./init.lua;
}
