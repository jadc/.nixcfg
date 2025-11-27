# Exiftool: Read and write meta information in files

{ config, lib, pkgs, ... }:

let
    name = "exiftool";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        home.packages = with pkgs; [ exiftool ];
    };
}
