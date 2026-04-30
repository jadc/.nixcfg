{ config, lib, ... }:

let
    name = "droidcam";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        # Install Droidcam
        programs.droidcam.enable = true;

        # Enable iOS USB support
        services.usbmuxd.enable = true;

        # Create virtual camera
        boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
        boot.kernelModules = ["v4l2loopback"];

        boot.extraModprobeConfig = ''
            options v4l2loopback devices=1 video_nr=1 card_label="DroidCam" exclusive_caps=1
        '';
    };
}
