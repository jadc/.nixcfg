{ pkgs, ... }:

{
    home.packages = with pkgs; [ yaml-language-server ];
    opts.neovim.servers = [ (builtins.readFile ./init.lua) ];
}
