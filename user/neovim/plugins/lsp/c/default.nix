{ pkgs, ... }:

{
    home.packages = with pkgs; [ clang-tools ];
    opts.neovim.servers = [ (builtins.readFile ./init.lua) ];
}
