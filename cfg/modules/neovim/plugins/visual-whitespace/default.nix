{ pkgs, ... }:

{
    programs.neovim.plugins = with pkgs.vimPlugins; [ visual-whitespace-nvim ];
}
