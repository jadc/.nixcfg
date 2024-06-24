# The following home.nix is shared amongst all profiles
# You shouldn't need to modify this file.

{ common, pkgs, ... }:

{
    home = {
        username = common.username;
        homeDirectory = "/home/${common.username}";
        stateVersion = "24.05";  # Do not need to update
    };

    # Automatically start systemd user services
    systemd.user.startServices = true;

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
