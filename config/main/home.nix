{
    imports =
        [
            # Setup
            ./../../system/gnome/home.nix
            ./../../user/qt
            ./../../user/xdg

            # Apps
            ./../../user/kitty
            ./../../user/chrome
            ./../../user/vesktop
            ./../../user/zathura
            ./../../user/spotify
            ./../../user/deluge
            ./../../user/obsidian
            ./../../user/minecraft
            ./../../user/qdirstat
            ./../../user/handbrake

            ## Multimedia
            ./../../user/audacity
            ./../../user/avidemux
            ./../../user/droidcam
            ./../../user/gimp
            ./../../user/inkscape
            ./../../user/jellyfin-player
            ./../../user/mpv
            ./../../user/obs
            ./../../user/puddletag
            ./../../user/spek

            # Command-line Interface
            ./../../user/archivers
            ./../../user/exiftool
            ./../../user/eza
            ./../../user/ffmpeg
            ./../../user/flac
            ./../../user/fzf
            ./../../user/gallery-dl
            ./../../user/git
            ./../../user/go
            ./../../user/htop
            ./../../user/imagemagick
            ./../../user/neovim
            ./../../user/ripgrep
            ./../../user/rsync
            ./../../user/shells
            ./../../user/sshfs
            ./../../user/texlive
            ./../../user/tmux
            ./../../user/yt
            ./../../user/zoxide

            # Scripts
            ./../../user/Scripts
            ./../../user/Scripts/rebuild.nix
            ./../../user/Scripts/spotifyify.nix
        ];
}
