{ config, ... }:

{
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        jack.enable = true;
        pulse.enable = true;
    };

    # Add user to audio group
    users.users.${config.common.username}.extraGroups = [ "audio" ];
}
