{ pkgs, ... }:

{
    home.packages = with pkgs; [ pyright ];
    opts.neovim.servers = [ (builtins.readFile ./init.lua) ];
}
