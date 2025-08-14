{ pkgs, ... }:

{
    programs.neovim.plugins = with pkgs.vimPlugins; [ rainbow-delimiters-nvim ];
}
