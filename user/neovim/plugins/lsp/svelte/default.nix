{ pkgs, ... }:

{
    home.packages = with pkgs; [ svelte-language-server ];
    opts.neovim.servers = [ (builtins.readFile ./init.lua) ];
}
