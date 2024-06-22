{ config, ... }:

{
    imports = 
        [
            ./../home.common.nix

            ./../../user/env.nix
            ./../../user/shells.nix
            ./../../user/scripts/enable.nix
            ./../../user/git.nix

            ./../../user/kitty.nix
            ./../../user/bspwm.nix
            ./../../user/maim.nix
        ];
    config = {
        # Custom user configuration
        monitors = {
            primary = "HDMI-0";
            secondary = "DP-0";
        };
    };
}
