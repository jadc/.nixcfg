{ pkgs, ... }:

{
    home.packages = with pkgs; [ rust-analyzer ];
    opts.neovim.servers = [ (builtins.readFile ./init.lua) ];
}
