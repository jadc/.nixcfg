{ config, pkgs, ... }:

{
    imports = [
        ../sound
        ../fonts
    ];

    services.xserver = {
        enable = true;
        xkb = {
            layout = "us";
            variant = "";

            # Bind caps lock to escape
            options = "caps:escape";
        };

        dpi = 120;

        # Disable default terminal
        excludePackages = [ pkgs.xterm ];

        # Enable desired window manager
        # (configure in home-manager)
        # TODO: find a way to not hardcode this
        windowManager.bspwm.enable = true;
        displayManager.lightdm.enable = true;
    };

    # Auto-login
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
