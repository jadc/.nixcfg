{ pkgs, ... }:

{
    programs.neovim.plugins = with pkgs.vimPlugins; [ nvim-treesitter ];
    xdg.configFile."nvim/after/plugin/treesitter.lua".source = ./init.lua;
}
