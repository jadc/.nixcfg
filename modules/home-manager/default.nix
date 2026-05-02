{ ... }:

{
    flake.modules.homeManager.home-manager = { config, lib, username, ... }: {
        home = {
            username = lib.mkForce username;
            homeDirectory = lib.mkForce ("/home/" + username);
            stateVersion = config.cfg.const.stateVersion;
        };

        # Let Home Manager install and manage itself.
        programs.home-manager.enable = true;

        # Automatically start systemd user services
        systemd.user.startServices = true;
    };
}
