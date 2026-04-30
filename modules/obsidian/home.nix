{ config, lib, pkgs, ... }:

let
    name = "obsidian";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        home.packages = [ pkgs.obsidian ];
    };
}
