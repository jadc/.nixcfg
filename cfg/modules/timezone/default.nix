{ config, lib, ... }:

let
    name = "timezone";
    self = config.cfg.system.${name};
in
{
    options.cfg.system.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        services.tzupdate.enable = true;

        # Allow timezone to be modified dynamically
        time.timeZone = lib.mkForce null;
    };
}
