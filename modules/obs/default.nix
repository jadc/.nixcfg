# OBS Studio: a free and open source software for video recording and live streaming

{ config, lib, ... }:

let
    name = "obs";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        programs.obs-studio.enable = true;
    };
}
