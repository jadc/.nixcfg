{
    imports =
        [
            # Kernel configuration
            ./../../system/kernel/flags/intel
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
            ./../../system/intel
            ./../../system/ios
            ./../../system/libinput
            ./../../system/networkmanager
            ./../../system/sound
            ./../../system/swapfile
            ./../../system/trim
            ./../../system/users

            # Requires superuser
            ./../../system/docker
            ./../../system/droidcam
            ./../../system/gnome
            ./../../system/steam
            ./../../system/syncthing
        ];
}
