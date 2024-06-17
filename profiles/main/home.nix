{ config, pkgs, ... }:

{
    imports = 
        [
            ./../../user/git.nix
        ];
    config = {
        home = {
            username = "jad";
            homeDirectory = "/home/jad";
            stateVersion = "24.05";  # Do not need to update

            # File management (e.g. dotfiles)
            #file = {};

            sessionVariables = {
                # EDITOR = "emacs";
            };
        };

        # Let Home Manager install and manage itself.
        programs.home-manager.enable = true;
    };
}
