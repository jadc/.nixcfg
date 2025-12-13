{ config, lib, pkgs, ... }:

let
    name = "ios";
    self = config.cfg.system.${name};
in
{
    options.cfg.system.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        services.usbmuxd.enable = true;
        environment.systemPackages = with pkgs; [ libimobiledevice ifuse ];
    };
}
