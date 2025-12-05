{ pkgs, ... }:

{
    cfg.system = {
        # Kernel configuration
        kernel = {
            enable = true;
            build = pkgs.linuxPackages_zen;
            flags = {
                performance = true;
                quiet = true;
            };
        };

        # Boot configuration
        systemd-boot.enable = true;

        # System configuration
        autologin.enable = true;
        automount.enable = true;
        fonts.enable = true;
        gc.enable = true;
        intel.enable = true;
        ios.enable = true;
        keyd.enable = true;
        libinput.enable = true;
        networkmanager.enable = true;
        nvidia.enable = true;
        remote.ssh.enable = true;
        sound.enable = true;
        swapfile.enable = true;
        trim.enable = true;
        users.enable = true;

        # Requires superuser
        docker.enable = true;
        droidcam.enable = true;
        gnome.enable = true;
        rgb = {
            enable = true;
            no-rgb.enable = true;
        };
        steam.enable = true;
        syncthing.enable = true;
    };

    networking.hostName = "jadc";
}
