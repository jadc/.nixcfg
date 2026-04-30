{ lib, username, ... }:

{
    home = {
        username = lib.mkForce username;
        homeDirectory = lib.mkForce ("/home/" + username);
        stateVersion = "26.05";  # Do not need to update
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    # Automatically start systemd user services
    systemd.user.startServices = true;
}
