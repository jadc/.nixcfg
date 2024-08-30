{ config, pkgs, ... }:

{
    imports =
        [
            # Standard configuration
            ./../configuration.common.nix
            ./common.nix
            ./hardware-configuration.nix

            # Kernel configuration
            ./../../system/kernel/zen
            ./../../system/kernel/flags/quiet
            ./../../system/kernel/flags/performance

            # Boot configuration
            #./../../system/grub
            ./../../system/systemd-boot

            # System configuration
            ./../../system/networkmanager
            ./../../system/users
            ./../../system/nvidia
            ./../../system/swapfile
            ./../../system/sshd
            ./../../system/trim
            ./../../system/automount

            # Requires superuser
            ./../../system/xserver
            ./../../system/steam
            #./../../system/virtualbox
            ./../../system/docker
            ./../../system/sunshine
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

    # Clean >= 30 day old generations every week
    nix.gc = {
        automatic = true;
        options = "--delete-older-than 7d";
        dates = "weekly";
    };

    # Paths to link
    environment.pathsToLink = [
        "/share/bash-completion"
        "/share/zsh"
    ];
}
