{ config, lib, ... }:

let
    name = "trim";
    self = config.cfg.system.${name};
in
{
    options.cfg.system.${name} = {
        enable = lib.mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        services.fstrim.enable = true;
    };
}
