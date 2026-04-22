{ config, lib, ... }:

let
    name = "gallery-dl";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = {
        enable = lib.mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        programs.gallery-dl.enable = true;
    };
}
