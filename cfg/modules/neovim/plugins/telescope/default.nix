{ pkgs, ... }:

{
    programs.neovim.plugins = with pkgs.vimPlugins; [ telescope-nvim nvim-web-devicons ];
    xdg.configFile."nvim/after/plugin/telescope.lua".source = ./init.lua;
}
