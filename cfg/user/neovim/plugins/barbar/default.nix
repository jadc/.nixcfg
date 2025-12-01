{ pkgs, ... }:

{
    programs.neovim.plugins = with pkgs.vimPlugins; [ barbar-nvim nvim-web-devicons ];
    xdg.configFile."nvim/after/plugin/barbar.lua".source = ./init.lua;
}
