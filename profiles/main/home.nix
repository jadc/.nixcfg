{ config, pkgs, ... }:

{
    imports = 
        [
            ./../../user/env.nix
            ./../../user/shells.nix
            ./../../user/scripts/enable.nix
            ./../../user/git.nix
        ];
    config = {
        home = {
            username = "jad";
            homeDirectory = "/home/jad";
            stateVersion = "24.05";  # Do not need to update

            # File management (e.g. dotfiles)
            #file = {};
        };

        # Let Home Manager install and manage itself.
        programs.home-manager.enable = true;
    };
}
