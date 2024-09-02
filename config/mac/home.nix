{
    imports =
        [
            # Standard configuration
            ./../home.common.nix
            ./common.nix

            # Apps
            ./../../user/app/kitty
            ./../../user/app/chrome
            ./../../user/app/vesktop
            ./../../user/app/zathura
            ./../../user/app/spotify
            ./../../user/app/syncthing
            ./../../user/app/deluge
            ./../../user/app/obsidian
            ./../../user/app/minecraft
            ./../../user/app/415

            ## Multimedia
            ./../../user/app/audacity
            ./../../user/app/spek
            #./../../user/app/puddletag
            #./../../user/app/avidemux
            ./../../user/app/gimp
            ./../../user/app/mpv
            #./../../user/app/obs
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

            # Scripts
            ./../../user/scripts
            ./../../user/scripts/spotifyify.nix
        ];
}
