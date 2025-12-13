{ config, lib, ... }:

let
    name = "autologin";
    self = config.cfg.system.${name};
in
{
    options.cfg.system.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        services.displayManager.autoLogin = {
            enable = true;
            user = config.cfg.const.username;
        };

        # Hack
        systemd.services."getty@tty1".enable = false;
        systemd.services."autovt@tty1".enable = false;
    };
}
