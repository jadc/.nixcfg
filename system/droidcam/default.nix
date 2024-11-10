{ config, ... }:

{
    # Install Droidcam
    programs.droidcam.enable = true;

    # Enable iOS USB support
    services.usbmuxd.enable = true;

    # Create virtual camera
    boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
    boot.kernelModules = ["v4l2loopback"];

    /*
    boot.extraModprobeConfig = ''
        options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';
    security.polkit.enable = true;
    */
}
