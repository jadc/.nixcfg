{ config, lib, pkgs, ... }:

let
    name = "archivers";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        home.packages = [
            pkgs.zip pkgs.unzip
            pkgs.p7zip
        ];
    };
}
