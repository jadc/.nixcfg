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
    };

    services.libinput = {
        enable = true;
        mouse.accelProfile = "flat";
        touchpad.accelProfile = "flat";
    };
}
