# Exiftool: Read and write meta information in files

{ config, lib, pkgs, ... }:

let
    name = "exiftool";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = {
        enable = lib.mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        home.packages = [ pkgs.exiftool ];
    };
}
