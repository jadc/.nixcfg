{ ... }:

let
    name = baseNameOf (toString ./.);
in
{
    flake.modules.generic.${name} = { lib, ... }: {
        options.cfg.${name} = {
            enable = lib.mkEnableOption name;
        };
    };

    flake.modules.nixos.${name} = { config, lib, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
            # Install bluetooth, but don't enable it
            hardware.bluetooth.enable = true;
            hardware.bluetooth.powerOnBoot = false;

            # Bluetooth pairing tool
            services.blueman.enable = true;

            # Enable A2DP sink
            hardware.bluetooth.settings.General.Enable = "Source,Sink,Media,Socket";
        };
    };
}
