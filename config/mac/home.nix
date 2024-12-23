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
            ./../../user/app/moonlight

            ## Multimedia
            ./../../user/app/audacity
            ./../../user/app/spek
            #./../../user/app/puddletag
            #./../../user/app/avidemux
            ./../../user/app/gimp
            ./../../user/app/mpv
            #./../../user/app/obs

            # Command-line Interface
            ./../../user/cli

            # Scripts
            ./../../user/scripts
            ./../../user/scripts/rebuild.nix
            ./../../user/scripts/spotifyify.nix
        ];
}
