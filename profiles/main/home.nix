{ config, pkgs, ... }:

{
    imports = 
        [
            ./../../user/env.nix
            ./../../user/shells.nix
            ./../../user/scripts/enable.nix
            ./../../user/git.nix

            ./../../user/kitty.nix
            ./../../user/bspwm.nix
            ./../../user/maim.nix
        ];
    config = {
        home = {
            username = (import ./consts.nix).username;
            homeDirectory = "/home/${(username}";
            stateVersion = "24.05";  # Do not need to update

            # File management (e.g. dotfiles)
            #file = {};
        };

        # Custom user configuration
        monitors = {
            primary = "HDMI-0";
            secondary = "DP-0";
        };

        # Let Home Manager install and manage itself.
        programs.home-manager.enable = true;
    };
}
