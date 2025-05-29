{ pkgs, ... }:

{
    home.packages = with pkgs; [ nixd ];
    opts.neovim.servers = [ (builtins.readFile ./init.lua) ];
}
