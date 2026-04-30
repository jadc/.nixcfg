# HP OmniBook Ultra Flip Laptop 14-fh0xxx (SBKPF)

{ pkgs, ... }:

{
    cfg = {
        # Kernel
        kernel = {
            enable = true;
            build = pkgs.linuxPackages_zen;
            flags = {
                intel = true;
                performance = true;
                quiet = true;
            };
        };

        # Boot
        systemd-boot.enable = true;

        # System
        autologin.enable = true;
        automount.enable = true;
        bluetooth.enable = true;
        fonts.enable = true;
        hp.enable = true;
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
            configurations.home = "/etc/wireguard/home.conf";
        };

        # Requires superuser
        docker.enable = true;
        gnome.enable = true;
        steam.enable = true;
        syncthing.enable = true;

        # Setup
        qt.enable = true;
        xdg.enable = true;

        # Apps
        brave.enable = true;
        deluge.enable = true;
        kitty = {
            enable = true;
            fontSize = 10;
        };
        minecraft.enable = true;
        obsidian.enable = true;
        qdirstat.enable = true;
        rnote.enable = true;
        spotify.enable = true;
        vesktop.enable = true;
        zathura.enable = true;
        moonlight.enable = true;

        # Multimedia
        audacity.enable = true;
        avidemux.enable = true;
        gimp.enable = true;
        inkscape.enable = true;
        jellyfin-player.enable = true;
        mpv.enable = true;
        obs.enable = true;
        puddletag.enable = true;
        spek.enable = true;
        virt-manager.enable = true;

        # Command-line Interface
        archivers.enable = true;
        bat.enable = true;
        claude-code.enable = true;
        direnv.enable = true;
        envs.enable = true;
        exiftool.enable = true;
        eza.enable = true;
        ffmpeg.enable = true;
        flac.enable = true;
        fzf.enable = true;
        gallery-dl.enable = true;
        gdb.enable = true;
        git.enable = true;
        htop.enable = true;
        hyperfine.enable = true;
        imagemagick.enable = true;
        poppler.enable = true;
        ripgrep.enable = true;
        rsync.enable = true;
        tmux.enable = true;
        yt.enable = true;
        zoxide.enable = true;

        # Scripts
        spotifyify.enable = true;
    };
}
