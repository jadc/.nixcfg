{ config, lib, ... }:

{
    home = {
        username = lib.mkForce config.cfg.const.username;
        homeDirectory = lib.mkForce ("/home/" + config.cfg.const.username);
        stateVersion = "24.05";  # Do not need to update
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    # Automatically start systemd user services
    systemd.user.startServices = true;
}
