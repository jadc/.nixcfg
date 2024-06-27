# To support nVidia dedicated graphics
{
    hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
        extraPackages = [ pkgs.nvidia_x11 ];
    };
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
    hardware.nvidia.modesetting.enable = true;
    boot.kernelParams = [ "nvidia-drm.modeset=1" ];
    modesetting.enable = true;
}
