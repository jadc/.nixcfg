{ config, lib, pkgs, ... }:

let
    name = "jellyfin-player";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        home.packages = [ pkgs.jellyfin-media-player ];
    };
}
