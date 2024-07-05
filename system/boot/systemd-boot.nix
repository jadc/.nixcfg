{ config, ... }:

{
    boot.loader = {
        systemd-boot.enable = true;

        efi = {
            canTouchEfiVariables = true;
            #efiSysMountPoint = config.common.bootMountPoint;
        };
    };
}
