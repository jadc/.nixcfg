{
    imports =
        [
            ./hardware-configuration.nix

            # Kernel configuration
            ./../../system/kernel/zen.nix
            ./../../system/kernel/flags/quiet.nix
            ./../../system/kernel/flags/performance.nix

            # Boot configuration
            ./../../system/boot/grub.nix
            #./../../system/boot/systemd-boot.nix

            # System configuration
            ./../../system/nix-gc.nix
            ./../../system/networkmanager.nix
            ./../../system/users.nix
            ./../../system/paths-to-link.nix
            #./../../system/nvidia.nix
            ./../../system/swapfile.nix
            ./../../system/sshd.nix

            # Requires superuser
            ./../../system/xserver.nix
            ./../../system/steam.nix
        ];
}
