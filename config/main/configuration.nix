{
    imports =
        [
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
            ./../../system/intel
            ./../../system/ios
            ./../../system/keyd
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
            ./../../system/droidcam
            ./../../system/gnome
            ./../../system/rgb
            ./../../system/rgb/no-rgb.nix
            ./../../system/steam
            ./../../system/syncthing
        ];
}
