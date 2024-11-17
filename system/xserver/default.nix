{ config, pkgs, ... }:

{
    imports = [
        ../sound
    ];

    services.xserver = {
        enable = true;

        # Bind caps lock to escape
        xkb.options = "caps:escape";

        # Disable default terminal
        excludePackages = [ pkgs.xterm ];

        # Enable desired window manager
        # (configure in home-manager)
        # TODO: find a way to not hardcode this
        windowManager.bspwm.enable = true;
    };

    # Auto-login
    services.xserver.displayManager.lightdm.enable = true;
    services.displayManager.autoLogin = {
        enable = true;
        user = "${config.common.username}";
    };

    # Disable mouse acceleration
    services.libinput = {
        enable = true;
        mouse.accelProfile = "flat";
        touchpad.accelProfile = "flat";
    };
}
