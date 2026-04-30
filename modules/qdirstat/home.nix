{ config, lib, pkgs, ... }:

let
    name = "qdirstat";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        home.packages = [ pkgs.qdirstat ];
    };
}
