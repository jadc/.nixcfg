{ config, lib, ... }:

let
    name = "swapfile";
    self = config.cfg.system.${name};
in
{
    options.cfg.system.${name} = {
        enable = lib.mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        swapDevices = [ {
            device = "/var/lib/swapfile";
            size = 16*1024;
        } ];
    };
}
