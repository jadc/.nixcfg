{ config, ... }:

{
    imports = 
        [
            ./../home.common.nix

            # Setup
            ./../../user/scripts/enable.nix
            ./../../user/display/compositor.nix
            ./../../user/display/gui.nix
            ./../../user/app/redshift.nix

            # Apps
            ./../../user/display/bspwm.nix
            ./../../user/app/shells.nix
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
            ./../../user/app/multimedia/audio.nix
            ./../../user/app/multimedia/video.nix
        ];
    config = {
        # Custom user configuration
        monitors = {
            primary = "HDMI-0";
            secondary = "DP-0";
        };
    };
}
