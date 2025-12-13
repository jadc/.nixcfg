{ pkgs, ... }:

{
    home.packages = with pkgs; [ typescript-language-server ];
    opts.neovim.servers = [ (builtins.readFile ./init.lua) ];
}
