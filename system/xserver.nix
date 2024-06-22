{ pkgs, ... }:

{
    imports = [
        #./sound.nix
        ./fonts.nix
    ];

    services.xserver = {
        enable = true;
        xkb = {
            layout = "us";
            variant = "";

            # Bind caps lock to escape
            options = "caps:escape";
        };

        # Disable default terminal
        excludePackages = [ pkgs.xterm ];

        # Enable desired window manager
        # (configure in home-manager)
        # TODO: find a way to not hardcode this
        windowManager.bspwm.enable = true;
    };

    services.displayManager = {
        sddm = {
            enable = true;

            # Automatically login
            # TODO: find a way to not hardcode this
            settings = {
                Autologin = {
                    User = "jad";
                    Session = "bspwm.desktop";
                };
            };
        };
    };

    services.libinput = {
        enable = true;
        mouse.accelProfile = "flat";
        touchpad.accelProfile = "flat";
    };
}
