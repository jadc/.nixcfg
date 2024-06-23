{ config, ... }:

{
    imports = 
        [
            ./../home.common.nix

            # CLI
            ./../../user/env.nix
            ./../../user/shells.nix
            ./../../user/scripts/enable.nix
            ./../../user/git.nix

            # GUI
            ./../../user/compositor.nix
            ./../../user/bspwm.nix
            ./../../user/gui.nix
            ./../../user/kitty.nix
            ./../../user/maim.nix
            ./../../user/launcher.nix
        ];
    config = {
        # Custom user configuration
        monitors = {
            primary = "HDMI-0";
            secondary = "DP-0";
        };
    };
}
