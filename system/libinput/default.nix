{
    # Disable mouse acceleration
    services.libinput = {
        enable = true;
        mouse.accelProfile = "flat";
        touchpad.accelProfile = "flat";
    };
}
