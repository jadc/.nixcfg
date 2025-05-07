{
    imports =
        [
            # Setup
            ./../../system/gnome/home.nix
            ./../../user/qt
            ./../../user/xdg

            # Apps
            ./../../user/chrome
            ./../../user/deluge
            ./../../user/handbrake
            ./../../user/kitty
            ./../../user/majora
            ./../../user/minecraft
            ./../../user/obsidian
            ./../../user/qdirstat
            ./../../user/sm64
            ./../../user/spotify
            ./../../user/vesktop
            ./../../user/zathura

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
