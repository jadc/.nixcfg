{ config, lib, ... }:

let
    name = "droidcam";
    self = config.cfg.system.${name};
in
{
    options.cfg.system.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        # Install Droidcam
        programs.droidcam.enable = true;

        # Enable iOS USB support
        services.usbmuxd.enable = true;

        # Create virtual camera
        boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
        boot.kernelModules = ["v4l2loopback"];

        boot.extraModprobeConfig = ''
            options v4l2loopback devices=1 video_nr=1 card_label="DroidCam" exclusive_caps=1
        '';
    };
}
