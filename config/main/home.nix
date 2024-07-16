{
    imports = 
        [
            # Setup
            ./../../user/scripts
            ./../../user/display/monitors.nix
            ./../../user/display/compositor.nix
            ./../../user/display/gui.nix
            ./../../user/app/redshift.nix
            ./../../user/app/notifications.nix

            # Apps
            ./../../user/display/bspwm.nix
            ./../../user/app/feh.nix
            ./../../user/app/kitty.nix
            ./../../user/app/maim.nix
            ./../../user/app/rofi.nix
            ./../../user/app/chromium.nix
            ./../../user/app/vesktop.nix
            ./../../user/app/zathura.nix
            ./../../user/app/spotify.nix
            ./../../user/app/syncthing.nix
            ./../../user/app/nautilus.nix
            ./../../user/app/deluge.nix

            ## Multimedia
            ./../../user/app/audacity.nix
            ./../../user/app/spek.nix
            ./../../user/app/puddletag.nix
            ./../../user/app/avidemux.nix
            ./../../user/app/gimp.nix
            ./../../user/app/inkscape.nix
            ./../../user/app/jellyfin-player.nix
            ./../../user/app/mpv.nix
            ./../../user/app/obs.nix
            ./../../user/cli/flac.nix
            ./../../user/cli/exiftool.nix
            ./../../user/cli/ffmpeg.nix
            ./../../user/cli/imagemagick.nix

            # Command-line Interface
            ./../../user/cli/shells.nix
            ./../../user/cli/git.nix
            ./../../user/cli/zoxide.nix
            ./../../user/cli/eza.nix
            ./../../user/cli/fzf.nix
            ./../../user/cli/nixvim
            ./../../user/cli/tmux.nix
            ./../../user/cli/texlive.nix
            ./../../user/cli/archivers.nix
            ./../../user/cli/rsync.nix
            ./../../user/cli/yt.nix
            ./../../user/cli/gallery-dl.nix
            ./../../user/cli/ripgrep.nix
            ./../../user/cli/htop.nix

            # Games
            ./../../user/games
        ];
    config = {
        # Custom user configuration
        monitors = {
            primary = "HDMI-0";
            secondary = "DP-0";
        };
    };
}
