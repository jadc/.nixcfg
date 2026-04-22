{ config, lib, pkgs, ... }:

let
    name = "virt-manager";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = {
        enable = lib.mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        home.packages = [
            pkgs.virt-manager
            pkgs.virt-viewer
        ];
    };
}
