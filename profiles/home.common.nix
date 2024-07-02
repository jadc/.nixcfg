# The following home.nix is shared amongst all profiles
# You shouldn't need to modify this file.

{ config, pkgs, ... }:

{
    imports = [ ./options.common.nix ];

    home = {
        username = config.common.username;
        homeDirectory = "/home/${config.common.username}";
        stateVersion = "24.05";  # Do not need to update
    };

    # Automatically start systemd user services
    systemd.user.startServices = true;

    # Use xdg user directories
    xdg.enable = true;

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
