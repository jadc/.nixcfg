{ config, lib, ... }:

let
    name = "nvidia";
    self = config.cfg.system.${name};
in
{
    options.cfg.system.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        # Enable OpenGL
        hardware.graphics.enable = true;

        # Load driver for Xorg and Wayland
        services.xserver.videoDrivers = [ "nvidia" ];
        boot.kernelParams = [ "nvidia-drm.modeset=1" ];

        hardware.nvidia = {
            modesetting.enable = true;

            # Use open drivers (for modern cards)
            open = true;

            # Enable settings menu (nvidia-settings)
            nvidiaSettings = true;

            # Use beta channel
            package = config.boot.kernelPackages.nvidiaPackages.beta;
        };
    };
}
