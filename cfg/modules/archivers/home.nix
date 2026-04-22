{ config, lib, pkgs, ... }:

let
    name = "archivers";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = {
        enable = lib.mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        home.packages = [
            pkgs.zip pkgs.unzip
            pkgs.p7zip
        ];
    };
}
