{ config, lib, pkgs, ... }:

let
    name = "sshfs";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        home.packages = [ pkgs.sshfs-fuse ];
    };
}
