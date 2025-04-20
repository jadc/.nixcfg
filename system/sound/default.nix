{ config, lib, pkgs, ... }:

{
    # environment.systemPackages = with pkgs; [ pavucontrol ];
    # hardware.pulseaudio.enable = lib.mkForce false;  # disable pulseAudio
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        jack.enable = true;
        pulse.enable = true;
    };

    # Add user to networkmanager group
    users.users.${config.common.username}.extraGroups = [ "audio" ];
}
