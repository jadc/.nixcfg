{ config, lib, pkgs, ... }:

let
    name = "imagemagick";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        home.packages = [ pkgs.imagemagick pkgs.libwebp ];
    };
}
