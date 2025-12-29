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
        keyd.enable = true;
        libinput.enable = true;
        networkmanager.enable = true;
        sound.enable = true;
        swapfile.enable = true;
        timezone.enable = true;
        trim.enable = true;
        users.enable = true;
        wireguard = {
            enable = true;
            configurations = [
                { name = "home"; configFile = "/etc/wireguard/home.conf"; }
            ];
        };

        # Requires superuser
        docker.enable = true;
        gnome.enable = true;
        steam.enable = true;
        syncthing.enable = true;
    };

    # Installs HP driver for proximity and gyroscopic sensors
    nixpkgs.overlays = [
        (final: prev: {
            linux-firmware = prev.linux-firmware.overrideAttrs (old: {
                postInstall = ''
                    cp ${./files/ishC_0207.bin} $out/lib/firmware/intel/ish/ish_lnlm_12128606.bin
                '';
            });
        })
    ];
    boot.kernelModules = [ "intel_ishtp_hid" ];
    hardware.firmware = [ pkgs.linux-firmware ];
    hardware.sensor.iio.enable = true;
}
