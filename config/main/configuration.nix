{ config, pkgs, ... }:

{
    imports =
        [
            # Standard configuration
            ./../configuration.common.nix
            ./common.nix
            ./hardware-configuration.nix

            # Kernel configuration
            ./../../system/kernel/flags/performance
            ./../../system/kernel/flags/quiet
            ./../../system/kernel/zen

            # Boot configuration
            #./../../system/grub
            ./../../system/systemd-boot

            # System configuration
            ./../../system/fonts
            ./../../system/automount
            ./../../system/gc
            ./../../system/networkmanager
            ./../../system/nfs
            ./../../system/nvidia
            ./../../system/remote/ssh
            ./../../system/swapfile
            ./../../system/trim
            ./../../system/users

            # Requires superuser
            #./../../system/virtualbox
            ./../../system/docker
            #./../../system/remote/x2go
            ./../../system/rgb
            ./../../system/rgb/no-rgb.nix
            ./../../system/steam
            ./../../system/xserver
            ./../../user/app/wireguard
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

    # Set default shell to zsh for all users
    # Unnecessary on macOS
    users.defaultUserShell = pkgs.zsh;

    # Paths to link
    environment.pathsToLink = [
        "/share/bash-completion"
        "/share/zsh"
    ];
}
