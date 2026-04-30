# Exiftool: Read and write meta information in files

{ config, lib, pkgs, ... }:

let
    name = "exiftool";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        home.packages = [ pkgs.exiftool ];
    };
}
