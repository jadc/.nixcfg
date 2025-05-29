{ pkgs, ... }:

{
    home.packages = with pkgs; [ gopls ];
    opts.neovim.servers = [ (builtins.readFile ./init.lua) ];
}
