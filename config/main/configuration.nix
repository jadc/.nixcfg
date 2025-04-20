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
            ./../../system/systemd-boot

            # System configuration
            ./../../system/autologin
            ./../../system/automount
            ./../../system/fonts
            ./../../system/gc
            ./../../system/ios
            ./../../system/libinput
            ./../../system/networkmanager
            ./../../system/nvidia
            ./../../system/remote/ssh
            ./../../system/sound
            ./../../system/swapfile
            ./../../system/trim
            ./../../system/users

            # Requires superuser
            ./../../system/docker
            ./../../system/gnome
            ./../../system/rgb
            ./../../system/rgb/no-rgb.nix
            ./../../system/steam
            ./../../system/syncthing
            #./../../system/xserver
            #./../../system/filebrowser
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
    users.defaultUserShell = pkgs.zsh;

    # Paths to link
    environment.pathsToLink = [
        "/share/bash-completion"
        "/share/zsh"
    ];
}
