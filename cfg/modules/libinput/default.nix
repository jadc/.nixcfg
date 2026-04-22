{ config, lib, ... }:

let
    name = "libinput";
    self = config.cfg.system.${name};
in
{
    options.cfg.system.${name} = {
        enable = lib.mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        # Disable mouse acceleration
        services.libinput = {
            enable = true;
            mouse.accelProfile = "flat";
            touchpad.accelProfile = "flat";
        };
    };
}
