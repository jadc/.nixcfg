{ config, lib, ... }:

let
    name = "libinput";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        # Disable mouse acceleration
        services.libinput = {
            enable = true;
            mouse.accelProfile = "flat";
            touchpad.accelProfile = "flat";
        };
    };
}
