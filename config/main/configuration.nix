{ config, ... }:

{
    imports =
        [
            # Standard configuration
            ./../configuration.common.nix
            ./common.nix
            ./hardware-configuration.nix

            # Kernel configuration
            ./../../system/kernel/zen.nix
            ./../../system/kernel/flags/quiet.nix
            ./../../system/kernel/flags/performance.nix

            # Boot configuration
            #./../../system/boot/grub.nix
            ./../../system/boot/systemd-boot.nix

            # System configuration
            ./../../system/nix-gc.nix
            ./../../system/networkmanager.nix
            ./../../system/users.nix
            ./../../system/paths-to-link.nix
            ./../../system/nvidia.nix
            ./../../system/swapfile.nix
            ./../../system/sshd.nix
            ./../../system/trim.nix

            # Requires superuser
            ./../../system/xserver.nix
            ./../../system/steam.nix
            ./../../system/virtualbox.nix
            ./../../system/docker.nix
        ];

    # Fix shutdown hang
    hardware.enableAllFirmware = true;

    # Setup locale
    time.timeZone = config.common.timeZone;
    i18n.defaultLocale = config.common.locale;
    i18n.extraLocaleSettings = {
        LC_ADDRESS = config.common.locale;
        LC_IDENTIFICATION = config.common.locale;
        LC_MEASUREMENT = config.common.locale;
        LC_MONETARY = config.common.locale;
        LC_NAME = config.common.locale;
        LC_NUMERIC = config.common.locale;
        LC_PAPER = config.common.locale;
        LC_TELEPHONE = config.common.locale;
        LC_TIME = config.common.locale;
    };


}
