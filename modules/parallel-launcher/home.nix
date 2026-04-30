{ config, lib, pkgs, ... }:

let
    name = "parallel-launcher";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        home.packages = [ pkgs.parallel-launcher ];
    };
}
