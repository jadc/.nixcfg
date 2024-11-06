{
    imports =
        [
            # Standard configuration
            ./../home.common.nix
            ./common.nix

            # Setup
            ./../../user/display/monitors
            ./../../user/display/compositor
            ./../../user/display/gui
            ./../../user/display/xresources
            ./../../user/app/redshift
            ./../../user/app/notifications

            # Apps
            ./../../user/display/bspwm
            ./../../user/app/feh
            ./../../user/app/kitty
            ./../../user/app/maim
            ./../../user/app/rofi
            ./../../user/app/chrome
            ./../../user/app/vesktop
            ./../../user/app/zathura
            ./../../user/app/spotify
            ./../../user/app/syncthing
            ./../../user/app/nautilus
            ./../../user/app/deluge
            ./../../user/app/obsidian
            ./../../user/app/idea
            ./../../user/app/minecraft
            ./../../user/app/clion
            ./../../user/app/clion/415.nix

            ## Multimedia
            ./../../user/app/audacity
            ./../../user/app/spek
            ./../../user/app/puddletag
            ./../../user/app/avidemux
            ./../../user/app/gimp
            ./../../user/app/inkscape
            ./../../user/app/jellyfin-player
            ./../../user/app/mpv
            ./../../user/app/obs
            ./../../user/cli/flac
            ./../../user/cli/exiftool
            ./../../user/cli/ffmpeg
            ./../../user/cli/imagemagick

            # Command-line Interface
            ./../../user/cli/shells
            ./../../user/cli/git
            ./../../user/cli/zoxide
            ./../../user/cli/eza
            ./../../user/cli/fzf
            ./../../user/cli/nixvim
            ./../../user/cli/tmux
            ./../../user/cli/texlive
            ./../../user/cli/archivers
            ./../../user/cli/rsync
            ./../../user/cli/yt
            ./../../user/cli/gallery-dl
            ./../../user/cli/ripgrep
            ./../../user/cli/htop
            ./../../user/cli/go
            ./../../user/cli/moshclient

            # Scripts
            ./../../user/scripts
            ./../../user/scripts/monitor.nix
            ./../../user/scripts/volume.nix
            ./../../user/scripts/rebuild.nix
            ./../../user/scripts/clock.nix
            ./../../user/scripts/spotifyify.nix
        ];
    config = {
        # Custom user configuration
        monitors = {
            primary = "HDMI-0";
            secondary = "";
        };
    };
}
