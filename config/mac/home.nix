{ inputs, ... }:

{
    imports =
        [
            # Standard configuration
            ./../home.common.nix
            ./common.nix

            # Apps
            ./../../user/app/kitty.nix
            ./../../user/app/chrome.nix
            #./../../user/app/vesktop.nix
            #./../../user/app/zathura.nix
            #./../../user/app/spotify.nix
            #./../../user/app/syncthing.nix
            #./../../user/app/deluge.nix

            ## Multimedia
            #./../../user/app/audacity.nix
            #./../../user/app/spek.nix
            #./../../user/app/puddletag.nix
            #./../../user/app/avidemux.nix
            #./../../user/app/gimp.nix
            #./../../user/app/inkscape.nix
            #./../../user/app/jellyfin-player.nix
            #./../../user/app/mpv.nix
            #./../../user/app/obs.nix
            ./../../user/cli/flac.nix
            ./../../user/cli/exiftool.nix
            ./../../user/cli/ffmpeg.nix
            ./../../user/cli/imagemagick.nix

            # Command-line Interface
            ./../../user/scripts
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
        ];
}
