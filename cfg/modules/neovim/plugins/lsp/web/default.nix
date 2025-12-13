{ pkgs, ... }:

{
    home.packages = with pkgs; [ vscode-langservers-extracted ];
    opts.neovim.servers = [ (builtins.readFile ./init.lua) ];
}
