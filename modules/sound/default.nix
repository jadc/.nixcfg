{ config, lib, username, ... }:

let
    name = "sound";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        security.rtkit.enable = true;
        services.pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            jack.enable = true;
            pulse.enable = true;
        };

        # Add user to audio group
        users.users.${username}.extraGroups = [ "audio" ];
    };
}
