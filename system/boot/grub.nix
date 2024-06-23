{ common, ... }:

{
    boot.loader.grub = {
        enable = true;
        device = common.rootDevice;
        useOSProber = true;
    };
}
