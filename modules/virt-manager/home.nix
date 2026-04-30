{ config, lib, pkgs, ... }:

let
    name = "virt-manager";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        home.packages = [
            pkgs.virt-manager
            pkgs.virt-viewer
        ];
    };
}
