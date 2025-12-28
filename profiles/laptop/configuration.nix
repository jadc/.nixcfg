# HP OmniBook Ultra Flip Laptop 14-fh0xxx (SBKPF)

{ pkgs, ... }:

{
    cfg.system = {
        # Kernel configuration
        kernel = {
            enable = true;
            build = pkgs.linuxPackages_zen;
            flags = {
                intel = true;
                performance = true;
                quiet = true;
            };
        };

        # Boot configuration
        systemd-boot.enable = true;

        # System configuration
        autologin.enable = true;
        automount.enable = true;
        bluetooth.enable = true;
        fonts.enable = true;
        gc.enable = true;
        hp-rotate.enable = true;
        intel.enable = true;
        ios.enable = true;
        keyd.enable = true;
        libinput.enable = true;
        networkmanager.enable = true;
        sound.enable = true;
        swapfile.enable = true;
        timezone.enable = true;
        trim.enable = true;
        users.enable = true;

        # Requires superuser
        docker.enable = true;
        gnome.enable = true;
        steam.enable = true;
        syncthing.enable = true;
    };
}
