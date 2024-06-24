{ config, ... }:

{
    imports = 
        [
            ./../home.common.nix

            # Setup
            ./../../user/cli/env.nix
            ./../../user/cli/shells.nix
            ./../../user/scripts/enable.nix
            ./../../user/display/compositor.nix
            ./../../user/display/gui.nix

            # CLI
            ./../../user/cli/git.nix

            # GUI
            ./../../user/display/bspwm.nix
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
