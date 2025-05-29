{ pkgs, ... }:

{
    home.packages = with pkgs; [ bash-language-server ];
    opts.neovim.servers = [ (builtins.readFile ./init.lua) ];
}
