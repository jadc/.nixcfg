{ pkgs, ... }:

{
    programs.neovim.plugins = with pkgs.vimPlugins; [ telescope-nvim ];
    xdg.configFile."nvim/after/plugin/telescope.lua".source = ./init.lua;
}
