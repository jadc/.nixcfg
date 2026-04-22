{ config, lib, pkgs, ... }:

let
    name = "jellyfin-player";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = {
        enable = lib.mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        home.packages = [ pkgs.jellyfin-media-player ];
    };
}
