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
            ./../../user/app/shells.nix
            ./../../user/app/feh.nix
            ./../../user/app/zoxide.nix
            ./../../user/app/git.nix
            ./../../user/app/nixvim/init.nix
            ./../../user/app/tmux.nix
            ./../../user/app/kitty.nix
            ./../../user/app/maim.nix
            ./../../user/app/launcher/rofi.nix
            ./../../user/app/chromium.nix
            ./../../user/app/vesktop.nix
            ./../../user/app/texlive.nix
            ./../../user/app/archivers.nix
            ./../../user/app/rsync.nix
            ./../../user/app/multimedia/audio.nix
            ./../../user/app/multimedia/video.nix
            ./../../user/app/multimedia/image.nix
            ./../../user/app/zathura.nix
            ./../../user/app/spotify.nix
            ./../../user/app/syncthing.nix
            ./../../user/app/nautilus.nix
            ./../../user/app/ripgrep.nix

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
