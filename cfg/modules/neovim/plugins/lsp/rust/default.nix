{ pkgs, ... }:

{
    home.packages = with pkgs; [ rust-analyzer clippy ];
    opts.neovim.servers = [ (builtins.readFile ./init.lua) ];
}
