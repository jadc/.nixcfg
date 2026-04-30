{ config, lib, username, ... }:

let
    name = "autologin";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        services.displayManager.autoLogin = {
            enable = true;
            user = username;
        };

        # Hack
        systemd.services."getty@tty1".enable = false;
        systemd.services."autovt@tty1".enable = false;
    };
}
