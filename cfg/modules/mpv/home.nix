{ config, lib, ... }:

let
    name = "mpv";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        programs.mpv = {
            enable = true;
            # TODO: configure settings
        };
    };
}
