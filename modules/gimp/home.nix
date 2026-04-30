{ config, lib, pkgs, ... }:

let
    name = "gimp";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        home.packages = [ pkgs.gimp ];
    };
}
