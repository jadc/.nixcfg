{ config, lib, pkgs, ... }:

let
    name = "poppler";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        home.packages = [ pkgs.poppler-utils ];
    };
}
