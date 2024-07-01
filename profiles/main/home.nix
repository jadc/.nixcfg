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
        ];
    config = {
        # Custom user configuration
        monitors = {
            primary = "HDMI-0";
            secondary = "DP-0";
        };
    };
}
