{ config, lib, ... }:

let
    name = "bluetooth";
    self = config.cfg.system.${name};
in
{
    options.cfg.system.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        # Install bluetooth, but don't enable it
        hardware.bluetooth.enable = true;
        hardware.bluetooth.powerOnBoot = false;

        # Bluetooth pairing tool
        services.blueman.enable = true;

        # Enable A2DP sink
        hardware.bluetooth.settings.General.Enable = "Source,Sink,Media,Socket";
    };
}
