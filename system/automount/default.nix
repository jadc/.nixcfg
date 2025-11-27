{ config, lib, ... }:

let
    name = "automount";
    self = config.cfg.system.${name};
in
{
    options.cfg.system.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        services.devmon.enable = true;
        services.gvfs.enable = true;
        services.udisks2.enable = true;
    };
}
