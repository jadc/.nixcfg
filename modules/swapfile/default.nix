{ config, lib, ... }:

let
    name = "swapfile";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        swapDevices = [ {
            device = "/var/lib/swapfile";
            size = 16*1024;
        } ];
    };
}
