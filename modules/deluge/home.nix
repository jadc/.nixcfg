{ config, lib, pkgs, ... }:

let
    name = "deluge";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        home.packages = [ pkgs.deluge ];
    };
}
