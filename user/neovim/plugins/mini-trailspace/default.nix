{ pkgs, ... }:

{
    programs.neovim.plugins = with pkgs.vimPlugins; [ mini-trailspace ];
    xdg.configFile."nvim/after/plugin/mini-trailspace.lua".source = ./init.lua;
}
