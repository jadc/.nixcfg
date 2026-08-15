# Options shared amongst all the NixOS profiles.

{ config, lib, ... }:

{
    imports = [ ./work.nix ];

    cfg = lib.mkDefault {
        # Kernel
        kernel = {
            enable = true;
            flags = {
                intel = true;
                performance = true;
                quiet = true;
            };
        };
        systemd-boot.enable = true;

        # Setup
        automount.enable = true;
        identity.passwordFile = "${config.cfg.save.path}/password";
        keyd.enable = true;
        networkmanager.enable = true;
        qt.enable = true;
        save.enable = true;
        sound.enable = true;
        timeZone = "America/Toronto";
        trim.enable = true;

        # Apps
        audacity.enable = true;
        avidemux.enable = true;
        bruno.enable = true;
        deluge.enable = true;
        discord.enable = true;
        docker.enable = true;
        gaming.enable = true;
        gimp.enable = true;
        helium.enable = true;
        jellyfin-player.enable = true;
        kitty.enable = true;
        minecraft.enable = true;
        moonlight.enable = true;
        mpv.enable = true;
        nautilus.enable = true;
        niri.enable = true;
        noctalia.enable = true;
        obs.enable = true;
        obsidian.enable = true;
        parallel-launcher.enable = true;
        puddletag.enable = true;
        qdirstat.enable = true;
        rnote.enable = true;
        spek.enable = true;
        steam.enable = true;
        swaybg.wallpaper = ../wallpaper.png;
        syncthing.enable = true;
        virt-manager.enable = true;
        wireguard = {
            enable = true;
            configurations.home = "/etc/wireguard/home.conf";
        };
        zathura.enable = true;

        # Command-line Interface
        claude-code.enable = true;
        flac.enable = true;
        gallery-dl.enable = true;
        yt.enable = true;
    };
}
