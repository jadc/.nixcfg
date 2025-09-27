# HP OmniBook Ultra Flip Laptop 14-fh0xxx (SBKPF)

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
            ./../../system/bluetooth
            ./../../system/fonts
            ./../../system/gc
            ./../../system/hp-rotate
            ./../../system/intel
            ./../../system/ios
            ./../../system/keyd
            ./../../system/libinput
            ./../../system/networkmanager
            ./../../system/sound
            ./../../system/swapfile
            ./../../system/trim
            ./../../system/users

            # Requires superuser
            ./../../system/docker
            ./../../system/gnome
            ./../../system/steam
            ./../../system/syncthing
        ];
}
