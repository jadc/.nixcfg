{ config, ... }:

{
    boot.loader.grub = {
        enable = true;
        device = config.common.rootDevice;
        useOSProber = true;
    };
}
