{ pkgs, ... }:

{
    home.packages = with pkgs; [ lua-language-server ];
    opts.neovim.servers = [ (builtins.readFile ./init.lua) ];
}
