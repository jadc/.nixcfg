{ pkgs, ... }:

{
    cfg.system = {
        # Kernel configuration
        kernel = {
            enable = true;
            build = pkgs.linuxPackages_zen;
            flags = {
                intel = true;
                nvidia = true;
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
        keyd.enable = true;
        libinput.enable = true;
        networkmanager.enable = true;
        nvidia.enable = true;
        sound.enable = true;
        ssh.enable = true;
        swapfile.enable = true;
        timezone.enable = true;
        trim.enable = true;
        users.enable = true;

        # Requires superuser
        docker.enable = true;
        droidcam.enable = true;
        gnome.enable = true;
        rgb = {
            enable = true;
            off = true;
        };
        steam.enable = true;
        syncthing.enable = true;
    };

    networking.hostName = "jadc";
}
