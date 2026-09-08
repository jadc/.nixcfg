# Options shared amongst all the NixOS profiles.

{ config, lib, pkgs, username, ... }:

{
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
        greeter = {
            package = pkgs.tuigreet;
            extraArgs = [ "--remember" "--user" username "--time" "--asterisks" ];
        };
        keyd.enable = true;
        networkmanager.enable = true;
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
        archivers.enable = true;
        bat.enable = true;
        btop.enable = true;
        claude-code.enable = true;
        direnv.enable = true;
        envs.enable = true;
        exiftool.enable = true;
        eza.enable = true;
        ffmpeg.enable = true;
        flac.enable = true;
        fzf.enable = true;
        gallery-dl.enable = true;
        git.enable = true;
        herdr.enable = true;
        hyperfine.enable = true;
        imagemagick.enable = true;
        lldb.enable = true;
        poppler.enable = true;
        ripgrep.enable = true;
        rsync.enable = true;
        xdg.enable = true;
        yt.enable = true;
        zoxide.enable = true;
        zsh.enable = true;
    };
}
