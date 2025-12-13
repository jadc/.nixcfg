{ config, lib, ... }:

let
    name = "sound";
    self = config.cfg.system.${name};
in
{
    options.cfg.system.${name} = with lib; {
        enable = mkEnableOption name;
    };

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
        users.users.${config.cfg.const.username}.extraGroups = [ "audio" ];
    };
}
