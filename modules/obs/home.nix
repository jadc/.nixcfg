# OBS Studio: a free and open source software for video recording and live streaming

{ config, lib, ... }:

let
    name = "obs";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        programs.obs-studio.enable = true;
    };
}
