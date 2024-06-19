{ pkgs, ... }:

{
    imports = [
        #./sound.nix
        ./fonts.nix
    ];

    services.xserver = {
        enable = true;
        layout = "us";
        xkb = {
            layout = "us";
            variant = "";

            # Bind caps lock to escape
            options = "caps:escape";
        };

        # Skip login manager
        displayManager = {
            startx.enable = true;
        };
    };

    services.libinput = {
        enable = true;
        mouse.accelProfile = "flat";
        touchpad.accelProfile = "flat";
    };
}
