{
    imports =
        [
            # System configuration
            ./hardware-configuration.nix
            ./../configuration.common.nix

            ./../../system/grub.nix
            ./../../system/locale.nix
            ./../../system/nix-gc.nix
            ./../../system/networkmanager.nix
            ./../../system/users.nix
            ./../../system/paths-to-link.nix

            # Requires superuser
            ./../../system/xserver.nix
        ];
}
