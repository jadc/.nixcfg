{ config, lib, pkgs, ... }:

let
    servers = [ (builtins.readFile ./init.lua) ] ++ config.opts.neovim.servers;
    concat = lib.concatStringsSep "\n" servers;
    script = pkgs.writeText "lsp.lua" concat;
in
{
    options.opts.neovim.servers = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
    };

    config = {
        xdg.configFile."nvim/after/plugin/lsp.lua".source = script;
    };
}
