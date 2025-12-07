{ config, ... }:

{
    imports = [
        ./../../cfg/modules/Scripts/rebuild.nix
        ./../../cfg/modules/Scripts/spotifyify.nix
    ];

    cfg.user = let cfg = config.cfg; in {
        # Setup
        qt.enable = true;
        xdg.enable = true;

        # Apps
        chrome.enable = true;
        deluge.enable = true;
        handbrake.enable = true;
        kitty.enable = true;
        minecraft.enable = true;
        obsidian.enable = true;
        parallel-launcher.enable = true;
        qdirstat.enable = true;
        rnote.enable = true;
        spotify.enable = true;
        vesktop.enable = true;
        zathura.enable = true;

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
        neovim.enable = true;
        poppler.enable = true;
        ripgrep.enable = true;
        rsync.enable = true;
        shells = {
            enable = true;
            aliases = cfg.const.aliases;
        };
        tmux.enable = true;
        yt.enable = true;
        zoxide.enable = true;

        # Scripts
        Scripts.enable = true;
    };
}
