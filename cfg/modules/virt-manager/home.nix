{ config, lib, pkgs, ... }:

let
    name = "virt-manager";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        home.packages = with pkgs; [
            virt-manager
            virt-viewer
        ];
    };
}
