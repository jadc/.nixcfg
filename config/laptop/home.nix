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
            ./../../user/kitty
            ./../../user/minecraft
            ./../../user/obsidian
            ./../../user/parallel-launcher
            ./../../user/qdirstat
            ./../../user/sm64
            ./../../user/spotify
            ./../../user/vesktop
            ./../../user/zathura

            ## Multimedia
            ./../../user/audacity
            ./../../user/avidemux
            ./../../user/gimp
            ./../../user/inkscape
            ./../../user/jellyfin-player
            ./../../user/mpv
            ./../../user/obs
            ./../../user/puddletag
            ./../../user/spek

            # Command-line Interface
            ./../../user/archivers
            ./../../user/bat
            ./../../user/direnv
            ./../../user/envs
            ./../../user/exiftool
            ./../../user/eza
            ./../../user/ffmpeg
            ./../../user/flac
            ./../../user/fzf
            ./../../user/gallery-dl
            ./../../user/gdb
            ./../../user/git
            ./../../user/go
            ./../../user/htop
            ./../../user/hyperfine
            ./../../user/imagemagick
            ./../../user/neovim
            ./../../user/poppler
            ./../../user/ripgrep
            ./../../user/rsync
            ./../../user/shells
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
