{ config, ... }:

{
    services.displayManager.autoLogin = {
        enable = true;
        user = config.common.username;
    };

    # Hack
    systemd.services."getty@tty1".enable = false;
    systemd.services."autovt@tty1".enable = false;
}
