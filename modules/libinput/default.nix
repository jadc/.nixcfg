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
            # Disable mouse acceleration
            services.libinput = {
                enable = true;
                mouse.accelProfile = "flat";
                touchpad.accelProfile = "flat";
            };
        };
    };
}
