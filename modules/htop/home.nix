{ config, lib, pkgs, ... }:

let
    name = "htop";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        programs.htop.enable = true;
        home.packages = [ pkgs.killall ];
    };
}
