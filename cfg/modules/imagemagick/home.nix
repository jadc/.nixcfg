{ config, lib, pkgs, ... }:

let
    name = "imagemagick";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = {
        enable = lib.mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        home.packages = [ pkgs.imagemagick pkgs.libwebp ];
    };
}
