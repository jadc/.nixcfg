# To support nVidia dedicated graphics
{
    hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
        extraPackages = [ pkgs.nvidia_x11 ];
    };
    services.xserver.videoDrivers = [ "nvidia" ];
    boot.kernelParams = [ "nvidia-drm.modeset=1" ];
    hardware.nvidia = {
        modesetting.enable = true;
        nvidiaSettings = true;
        open = false;

        # Use beta channel
        package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
}
