{ config, ... }:

{
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
}
