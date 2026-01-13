{ pkgs, ... }:

{
    programs.neovim.plugins = with pkgs.vimPlugins; [ vim-tmux-navigator ];
    xdg.configFile."nvim/after/plugin/vim-tmux-navigator.lua".source = ./init.lua;
}
